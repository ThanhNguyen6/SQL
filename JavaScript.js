
//problem 1
let sum = 0;
for (let key in salaries) {
    sum += salaries[key];
}


//problem 2
function multiplyNumeric(obj) {
    for (let key in obj) {
        if (typeof obj[key] == 'number') {
            obj[key] *= 2;
        }
    }
}

//pr3
function checkEmailId(str) {
    if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(str)) {
        return true;
    }
    return false;
}

//pr 4
function truncate(str, maxlength) {
    return (str.length > maxlength) ?
        str.slice(0, maxlength - 1) + '…' : str;
}

//pr5 
let arr = ["James, Brennnie"]
arr.push('Robert')
arr[Math.floor(arr.length/2)] = "Calvin"
console.log(arr.shift())
arr.unshift('Regal')
arr.unshift('Rose')

//pr 6
function isvalid(cardnumber) {
    var lastdigit = cardnumber % 10;
    cardnumber /= 10;
    sum = 0
    while (cardnumber != 0) {
        sum += (cardnumber % 10) * 2
        cardnumber /= 10
    }
    if (sum % 10 == lastdigit) {
        return true;
    }
    return false;
}

function isallow(cardnumber, prefix) {
    for (let pre in prefix) {
        strPre = pre.toString()
        if (!cardnumber.startsWith(strPre)) {
            return false;
        }
        return true;
    }
}
function validateCards(arrayCards, prefixNotAlllowed) {
    var returnJson = {"creditcard":[]}
    for (let card in arrayCards) {
        let cardNumber = parseInt(card)
        returnJson.creditcard.push({ "card": card, "isValid": isvalid(cardNumber), "isallow": isallow(car, prefixNotAlllowed) })
    }
    return returnJson
}

//pr 7

function checkEmailHackkerank(str) {
    if (/^[a-z]{1,6}_?\d{0,4}+@hackerrank.com*$/.test(str)) {
        return true;
    }
    return false;
}
