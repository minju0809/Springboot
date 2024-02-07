
let currentTitle = document.getElementById('current-year-month');
let calendarBody = document.getElementById('calendar-body');
let today = new Date();
console.log(today);
let first = new Date(today.getFullYear(), today.getMonth(), 1);
let dayList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
let monthList = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
let leapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // 윤년
let notLeapYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // 평년
let pageFirst = first;
let pageYear;
pageYear = first.getFullYear() % 4 === 0 ? leapYear : notLeapYear;

function showCalendar() {
    let monthCnt = 100;
    let cnt = 1;
    for (let i = 0; i < 6; i++) {
        let tr = document.createElement('tr');
        tr.setAttribute('id', monthCnt);
        for (let j = 0; j < 7; j++) {
            if ((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]) {
                let td = document.createElement('td');
                tr.appendChild(td);
            } else {
                let td = document.createElement('td');
                td.textContent = cnt;
                td.setAttribute('id', cnt);
                tr.appendChild(td);
                cnt++;
            }
        }
        monthCnt++;
        calendarBody.appendChild(tr);
    }
}
showCalendar();

function removeCalendar() {
    let catchTr = 100;
    for (let i = 100; i < 106; i++) {
        let tr = document.getElementById(catchTr);
        tr.remove();
        catchTr++;
    }
}

function updateCalendar() {
    inputBox.value = "";
    const divs = document.querySelectorAll('#input-list > div');
    divs.forEach(function (e) {
        e.remove();
    });
    const btns = document.querySelectorAll('#input-list > button');
    btns.forEach(function (e1) {
        e1.remove();
    });
    today = new Date(today.getFullYear(), today.getMonth(), 1); // 현재 월의 1일로 설정
    first = new Date(today.getFullYear(), today.getMonth(), 1);
    pageYear = first.getFullYear() % 4 === 0 ? leapYear : notLeapYear;
    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;' + first.getFullYear();
    removeCalendar();
    showCalendar();
    clickedDate1 = document.getElementById(today.getDate());
    clickedDate1.classList.add('active');
    showMain();
    reshowingList();
    clickStart();
}

function prev() {
    today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate()); // 이전 월로 변경
    updateCalendar();
    reshowingList(); // 이전 월로 변경 시 todo 리스트 다시 표시
}

function next() {
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate()); // 다음 월로 변경
    updateCalendar();
    reshowingList(); // 다음 월로 변경 시 todo 리스트 다시 표시
}

// function prev() {
//     inputBox.value = "";
//     const divs = document.querySelectorAll('#input-list > div');
//     divs.forEach(function (e) {
//         e.remove();
//     });
//     const btns = document.querySelectorAll('#input-list > button');
//     btns.forEach(function (e1) {
//         e1.remove();
//     });
//     if (pageFirst.getMonth() === 1) {
//         pageFirst = new Date(first.getFullYear() - 1, 12, 1);
//         first = pageFirst;
//         pageYear = first.getFullYear() % 4 === 0 ? leapYear : notLeapYear;
//     } else {
//         pageFirst = new Date(first.getFullYear(), first.getMonth() - 1, 1);
//         first = pageFirst;
//     }
//     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
//     currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;' + first.getFullYear();
//     removeCalendar();
//     showCalendar();
//     showMain();
//     clickedDate1 = document.getElementById(today.getDate());
//     clickedDate1.classList.add('active');
//     clickStart();
//     reshowingList();
// }

// function next() {
//     inputBox.value = "";
//     const divs = document.querySelectorAll('#input-list > div');
//     divs.forEach(function (e) {
//         e.remove();
//     });
//     const btns = document.querySelectorAll('#input-list > button');
//     btns.forEach(function (e1) {
//         e1.remove();
//     });
//     if (pageFirst.getMonth() === 12) {
//         pageFirst = new Date(first.getFullYear() + 1, 1, 1);
//         first = pageFirst;
//         pageYear = first.getFullYear() % 4 === 0 ? leapYear : notLeapYear;
//     } else {
//         pageFirst = new Date(first.getFullYear(), first.getMonth() + 1, 1);
//         first = pageFirst;
//     }
//     today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
//     currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;' + first.getFullYear();
//     removeCalendar();
//     showCalendar();
//     showMain();
//     clickedDate1 = document.getElementById(today.getDate());
//     clickedDate1.classList.add('active');
//     clickStart();
//     reshowingList();
// }

function showMain() {
    const mainTodayDay = document.querySelector("#main-day")
    const mainTodayDate = document.querySelector("#main-date")
    mainTodayDay.innerHTML = dayList[today.getDay()];
    mainTodayDate.innerHTML = today.getDate();
}
let clickedDate1 = document.getElementById(today.getDate());
clickedDate1.classList.add('active');
let prevBtn = document.getElementById('prev');
let nextBtn = document.getElementById('next');
prevBtn.addEventListener('click', prev);
nextBtn.addEventListener('click', next);
let tdGroup = [];

function clickStart() {
    for (let i = 1; i <= pageYear[first.getMonth()]; i++) {
        tdGroup[i] = document.getElementById(i);
        tdGroup[i].addEventListener('click', changeToday);
    }
}
clickStart();

function changeToday(e) {
    for (let i = 1; i <= pageYear[first.getMonth()]; i++) {
        if (tdGroup[i]) {
            if (tdGroup[i].classList.contains('active')) {
                tdGroup[i].classList.remove('active');
            }
        }
    }
    clickedDate1 = e.currentTarget;
    clickedDate1.classList.add('active');
    today = new Date(today.getFullYear(), today.getMonth(), clickedDate1.id);
    showMain();
    keyValue = today.getFullYear() + '' + today.getMonth() + '' + today.getDate();
    reshowingList();
}


function reshowingList() {
    keyValue = today.getFullYear() + '' + today.getMonth() + '' + today.getDate();
    if (todoList[keyValue] === undefined || todoList[keyValue].length === 0) {
        inputList.textContent = '';
        todoList[keyValue] = [];
        const divs = document.querySelectorAll('#input-list > div');
        divs.forEach(function (e) {
            e.remove();
        });
        const btns = document.querySelectorAll('#input-list > button');
        btns.forEach(function (e1) {
            e1.remove();
        });
    } else {
        const divs = document.querySelectorAll('#input-list > div');
        divs.forEach(function (e) {
            e.remove();
        });
        const btns = document.querySelectorAll('#input-list > button');
        btns.forEach(function (e1) {
            e1.remove();
        });
        let divElement = document.createElement('div');
        for (let i = 0; i < todoList[keyValue].length; i++) {
            let divElement = document.createElement('div');
            divElement.textContent = '-' + todoList[keyValue][i];
            let btnElement = document.createElement('button');
            btnElement.setAttribute('type', 'button');
            btnElement.setAttribute('id', 'del-ata');
            btnElement.setAttribute('id', dataCnt + keyValue);
            btnElement.setAttribute('class', 'del-data');
            btnElement.textContent = delText;
            inputList.appendChild(divElement);
            inputList.appendChild(btnElement);
            divElement.addEventListener('click', checkList);
            btnElement.addEventListener('click', deleteTodo);
            inputBox.value = '';

            function deleteTodo() {
                divElement.remove();
                btnElement.remove();
                // 삭제한 값이 나타나지 않도록 해당 항목을 todoList에서 제거
                todoList[keyValue].splice(i, 1);
            }
        }
    }
}

let inputBox = document.getElementById('input-box');
let inputDate = document.getElementById('input-data');
let inputList = document.getElementById('input-list');
let delText = 'X';
inputDate.addEventListener('click', addTodoList);
let dataCnt = 1;
let keyValue = today.getFullYear() + '' + today.getMonth() + '' + today.getDate();
let todoList = [];
todoList[keyValue] = [];

function addTodoList() {
    let divElement = document.createElement('div');
    divElement.textContent = '-' + inputBox.value;
    let btnElement = document.createElement('button');
    btnElement.setAttribute('type', 'button');
    btnElement.setAttribute('id', 'del-ata');
    btnElement.setAttribute('id', dataCnt + keyValue);
    btnElement.setAttribute('class', "del-data");
    btnElement.textContent = delText;
    inputList.appendChild(divElement);
    inputList.appendChild(btnElement);
    todoList[keyValue].push(inputBox.value);
    dataCnt++;
    inputBox.value = '';
    divElement.addEventListener('click', checkList);
    btnElement.addEventListener('click', deleteTodo);

    function deleteTodo() {
        divElement.remove();
        btnElement.remove();
    }
}
console.log(keyValue);

function checkList(e) {
    const clickedDiv = e.currentTarget;
    // const clickedIndex = Array.from(inputList.children).indexOf(clickedDiv); // 클릭한 div의 인덱스
    clickedDiv.classList.toggle('checked'); // 'checked' 클래스를 토글 (추가/제거)
}

if (pageFirst.getMonth() === 12) {
    pageFirst = new Date(first.getFullYear() + 1, 1, 1);
    first = pageFirst;
    pageYear = first.getFullYear() % 4 === 0 ? leapYear : notLeapYear;
} else {
    pageFirst = new Date(first.getFullYear(), first.getMonth() + 1, 1);
    first = pageFirst;
}
currentTitle.innerHTML =
    monthList[first.getMonth() - 1] +
    "&nbsp;&nbsp;&nbsp;&nbsp;" +
    first.getFullYear();

showMain();