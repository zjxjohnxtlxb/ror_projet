/*
 * @Date: 2021-08-19 11:47:25
 * @LastEditors: Junxi ZHANG
 * @LastEditTime: 2021-08-19 19:11:51
 * @FilePath: /Frontend/app/javascript/packs/air_guitar.js
 */

const back = document.getElementById("back");

back.addEventListener('click', () => {
    window.location.href = '/candidat/partiel/profil';
});

const modelParams = {
    flipHorizontal: true, // flip e.g for video
    imageScaleFactor: 0.7, // reduce input image size for gains in speed.
    maxNumBoxes: 1, // maximum number of boxes to detect
    iouThreshold: 0.5, // ioU threshold for non-max suppression
    scoreThreshold: 0.89 // confidence threshold for predictions.
};

navigator.getUserMedia =
    navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia;

const video = document.querySelector("#video");
const audio = document.querySelector("#audio");
let model;

handTrack.startVideo(video).then(status => {
    if (status) {
        navigator.getUserMedia({
                video: {}
            },
            stream => {
                video.srcObject = stream;
                setInterval(runDetection, 500);
            },
            error => console.error(error)
        );
    }
});

const runDetection = () => {
    model.detect(video).then(predictions => {
        if (predictions.length) {
            let hand1 = predictions[0].bbox;
            let x = hand1[0];
            let y = hand1[1];
            let notes = document.querySelectorAll("h3");

            if (y > 100 && y < 400) {
                if (x <= 100) { //E C B A
                    audio.src = notes[3].dataset.source;
                } else if (x > 300) {
                    audio.src = notes[0].dataset.source;
                } else if (x > 200) {
                    audio.src = notes[1].dataset.source;
                } else if (x > 100) {
                    audio.src = notes[2].dataset.source;
                }
            }

            audio.play();
        }
    });
};

handTrack.load().then(lmodel => (model = lmodel));