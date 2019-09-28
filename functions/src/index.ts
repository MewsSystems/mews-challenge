import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as R from 'ramda';
import {DocumentSnapshot} from 'firebase-functions/lib/providers/firestore';
import Timestamp = admin.firestore.Timestamp;

admin.initializeApp();
const db = admin.firestore();

export const onQuestionAnswered = functions.firestore
    .document('users/{userId}/games/{gameId}/questions/{questionId}').onUpdate((async (change, context) => {
        const wasFinished = await db.runTransaction(async transaction => {
            const questionsRef = change.after.ref.parent;
            const questions = (await questionsRef.get()).docs.map((d) => d.data());
            const userGame = await questionsRef.parent!.get();
            const gameData = userGame.data()!;
            if (!!gameData.end) {
                console.log('Game is already completed. Abort.');
                return false;
            }

            const rightAnswersByTags: any = {};
            if (questions.filter(q => !!q.answer).length === questions.length) {
                const gameQuestionsRef = db.collection('games').doc(context.params.gameId).collection('questions');
                const gameQuestions = (await gameQuestionsRef.get()).docs.map(d => d.data());

                let rightAnswers = 0;
                questions.forEach((q) => {
                    if (q.answer === (gameQuestions.find(d => d.id === q.id) || {}).rightAnswer) {
                        rightAnswers++;
                        const key: string = (gameData.type == 0 ? 'DESIGN' : q.tag).toUpperCase();
                        rightAnswersByTags[key] = (rightAnswersByTags[key] || 0) + 1;
                    }
                });

                console.log('Completing game.');
                await transaction.update(questionsRef.parent!, {
                    end: Timestamp.now(),
                    rightAnswerCount: rightAnswers,
                    rightAnswersByTags,
                });
                return true;
            } else {
                console.log('Not all questions has been answered. Abort.');
            }
            return false;
        });

        if (!wasFinished) return;

        try {
            await updateLeaderboard(context.params.gameId);
        } catch (e) {
            console.error(e);
        }
    }));

export const onGameCreated = functions.firestore
    .document('users/{userId}/games/{gameId}').onCreate((async (snapshot, context) =>
        db.runTransaction((async transaction => {
            const gameRef = db.collection('games').doc(context.params.gameId);
            const game = (await gameRef.get()).data();
            if (!game) return;

            const questions = (await gameRef.collection('questions').get()).docs;

            await transaction.set(snapshot.ref, {
                title: game.title,
                description: game.description,
                type: game.type,
                id: context.params.gameId,
                questionCount: questions.length,
                start: Timestamp.now(),
            });

            const promises = questions.map(v => v.data())
                .sort(() => Math.random() - .5)
                .map(((value, index) => {
                    const ref = snapshot.ref.collection('questions').doc(value.id);
                    return transaction.set(ref, {
                        ...value,
                        answers: value.answers.sort(() => Math.random() - .5).map((a: any, i: number) => ({
                            ...a,
                            letter: LETTERS[i],
                        })),
                        position: index + 1,
                        rightAnswer: null,
                    });
                }));

            return Promise.all(promises);
        }))));

const LETTERS = ['A', 'B', 'C', 'D'];

async function updateLeaderboard(gameId: string) {
    const users = await db.collection('users').get().then((s) => s.docs);
    const compact = R.reject(R.isNil);

    const resultsData = users.map(async (q) => {
        const game = await q.ref.collection('games').doc(gameId).get();
        return getResult(q, game);
    });
    const results = compact(await Promise.all(resultsData));

    await db.runTransaction(async t => {
        const resultsRef = db.collection('results');
        results.forEach(r => t.set(resultsRef.doc(gameId).collection('results').doc(r.userId), r));
    });
}

function getResult(q: DocumentSnapshot, snapshot: DocumentSnapshot): any {
    if (!snapshot.exists) return null;
    const result: any = {};
    const data = snapshot.data() as any;
    if (!data['end']) return null;
    result.rightAnswerCount = data['rightAnswerCount'];
    result.questionCount = data['questionCount'];
    result.start = data['start'];
    result.end = data['end'];
    result.userId = q.id;

    const names = (q.data()!['name'] as string).split(' ');
    const firstName = R.head(names) || '';
    const lastName = R.pipe(
        R.tail,
        R.map(R.head),
        R.map(a => `${a}.`),
        R.join(' ')
    )(names);
    result.name = [firstName, lastName].join(' ');
    return result;
}
