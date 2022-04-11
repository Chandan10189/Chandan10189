import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    myQuestions =[
        {
            id: "Question 1",
            question : "Which of the following is not a template look?",
            answer :{
                a: "for:each",
                b: "iterator",
                c: "map loop"
            },
            correctAnswer:"c"
        },
        {
            id: "Question 2",
            question : "Which of the file is invalid in LWC?",
            answer :{
                a: ".svg",
                b: ".apex",
                c: ".js"
            },
            correctAnswer:"b"
        },
        {
            id: "Question 3",
            question : "Which of the folloeing is not a directive?",
            answer :{
                a: "for:each",
                b: "if:true",
                c: "@api"
            },
            correctAnswer:"c"
        }
    ]
}