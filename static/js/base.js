function redirectToFile(path) {
    window.location.href = path;
}

function isEmpty(str) {
    if (str == null || str == "") 
        return true;
    return false;
}

// email test functions

function containsOneEmailSign(str) {
    if (str.indexOf('@') != str.lastIndexOf('@'))
        return false;
    return true;
}

function noEmailSign (str) {
    if (str.indexOf('@') == -1)
        return true;
    return false;
}

function emailRecipientNameNotContainsSpecialSigns(str) {
    for (i = 0; i < str.length; i++) {
        if ((str.charAt(i) < '0' || (str.charAt(i) > '9' && str.charAt(i) < 'A') || (str.charAt(i) > 'Z' && str.charAt(i) < 'a') || str.charAt(i) > 'z') && str.charAt(i) != '.' && str.charAt(i) != '_' && str.charAt(i) != '-' && str.charAt(i) != '+' || str.length > 64) {
            return false;
        }
    }
    return true;
}

function emailRecipientNameNotStartsOrEndsWithSpecialSigns(str) {
    if ((str.charAt(0) < '0' || (str.charAt(0) > '9' && str.charAt(0) < 'A') || (str.charAt(0) > 'Z' && str.charAt(0) < 'a') || str.charAt(0) > 'z') || (str.charAt(str.length - 1) < '0' || (str.charAt(str.length - 1) > '9' && str.charAt(str.length - 1) < 'A') || (str.charAt(str.length - 1) > 'Z' && str.charAt(str.length - 1) < 'a') || str.charAt(str.length - 1) > 'z')) {
        return false;
    }
    return true;
}

function emailDomainNotContainsSpecialSigns(str) {
    if (str.length > 253) {
        return false;
    }
    for (i = 0; i < str.length; i++) {
        if (i == 0 || i == str.length - 1) {
            if (str.charAt(i) == '.' || str.charAt(i) == "-") {
                return false;
            }
        }
        if ((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || str.charAt(i) == '-' || str.charAt(i) == '.') {
            // pass
        } else {
            return false;
        }
    }
    return true;
}

function specialSignAndEmailSignNotTogether(str) {
    if ((str.charAt(str.length - 1) < 'a' || str.charAt(str.length - 1) > 'z') && (str.charAt(str.length - 1) < 'A' || str.charAt(str.length - 1) > 'Z') && (str.charAt(str.length - 1) < '0' || str.charAt(str.length - 1) > '9')) {
        return false;
    }
    return true;
}

function emailHasEnding(str) {
    var lastDote = str.lastIndexOf('.');
    var endingLen = str.length - lastDote;
    if (endingLen < 2 || endingLen > 5)
        return false;
    return true;
}

function emailCorrect(str, correct, errorMsg) {
    if (isEmpty(str)) {
        errorMsg = errorMsg + "\n" + "* שדה המייל ריק";
        correct = false;
    } else {
        if (noEmailSign(str)) {
            errorMsg = errorMsg + "\n" + "* שדה המייל לא מכיל @";
            correct = false;
        }
        if (!noEmailSign(str)) {
            if (!containsOneEmailSign(str)) {
                errorMsg = errorMsg + "\n" + "* שדה המייל מכיל יותר מ @ אחד";
                correct = false;
            } else {
                var [recipient, domain] = str.split('@');
                if (!emailDomainNotContainsSpecialSigns(domain)) {
                    errorMsg = errorMsg + "\n" + "* דומיין של המייל מכיל סימנים הלא מתאימים לכתובת מייל או הוא ארוך מדי";
                    correct = false;
                }
                if (!emailRecipientNameNotStartsOrEndsWithSpecialSigns(recipient)) {
                    errorMsg = errorMsg + "\n" + "* אסור שיהיו סימנים בתחילה או בסוף שם של המייל";
                    correct = false;
                }
                if (!emailRecipientNameNotContainsSpecialSigns(recipient)) {
                    errorMsg = errorMsg + "\n" + "* שם של המייל מכיל סימנים לא מתאימים למייל או שהוא ארוך מדי";
                    correct = false;
                }
                if (!specialSignAndEmailSignNotTogether(recipient)) {
                    errorMsg = errorMsg + "\n" + "* בשדה המייל, הנקודה נמצאת לפני או אחרי הסימן @";
                    correct = false;
                }
                if (!emailHasEnding(domain)) {
                    errorMsg = errorMsg + "\n" + "* המייל לא מכיל סיומת או מכיל סיומת לא חוקית";
                    correct = false;
                }
            }
        }
        
    }
    return [correct, errorMsg];
}
//************************************************************************************

// name test function

function nameCorrect(str, correct, errorMsg) {
    if (isEmpty(str)) {
        errorMsg = errorMsg + "\n" + "* שדה השם ריק";
        correct = false;
    } else {
        var upperLetters = 0;
        var lowerLetters = 0;
        var hebrewLetters = 0;
        var spaces = 0;
        for (i = 0; i < str.length; i++) {
            if (str[i] >= 'a' && str[i] <= 'z')
                lowerLetters++;
            else if (str[i] >= 'A' && str[i] <= 'Z')
                upperLetters++;
            else if (str[i] >= 'א' && str[i] <= 'ת')
                hebrewLetters++;
            else if (str[i] == ' ')
                spaces++;
        }
        if (spaces == 0) {
            errorMsg = errorMsg + "\n" + "* נא להקליד שם מלא";
            correct = false
        } else if (lowerLetters + upperLetters + hebrewLetters + spaces != str.length) {
            errorMsg = errorMsg + "\n" + "* השם מכיל סימנים, לכן השם הוא לא נכון";
            correct = false;
        }
    }
    return [correct, errorMsg];
}

//*************************************************************************************

// phone number function

function phoneNumberCorrect(str, correct, errorMsg) {
    var signs = false;
    if (isEmpty(str)) {
        errorMsg = errorMsg + "\n" + "* שדה מספר הפלאפון ריק";
        correct = false;
    } else {
        for (i = 0; i < str.length; i++) {
            if ((str.charAt(i) > '9' || str.charAt(i) < '0')) {
                signs = true;
            }
        }
        if (signs) {
            errorMsg = errorMsg + "\n" + "* שדה של מספר הפלאפון מכיל תווים שלא מספריים";
            correct = false;
        }
        if ((str.length > 10 || str.length < 9)) {
            errorMsg = errorMsg + "\n" + "* מספר הפלאפון ארוך או קצר מדי";
            correct = false;
        }
    }
    return [correct, errorMsg];
}
//*************************************************************************************

// password test function

function passwordCorrect(str, correct, errorMsg) {
    var symbols = 0;
    var digits = 0;
    var capitalLetters = 0;
    var smallLetters = 0;
    if (str.length < 12) {
        correct = false;
        errorMsg = errorMsg + "\n" + "* הסיסמה קצרה מדי";
    }
    for (i = 0; i < str.length; i++) {
        if (str.charAt(i) >= 'a' && str.charAt(i) <= 'z') {
            smallLetters++;
        }
        else if (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') {
            capitalLetters++;
        }
        else if (str.charAt(i) >= '0' && str.charAt(i) <= '9') {
            digits++;
        }
        else {
            symbols++;
        }
    }
    if (symbols == 0) {
        correct == false;
        errorMsg = errorMsg + "\n" + "* הסיסמה צריכה להכיל לפחות סימן אחד";
    }
    if (digits == 0) {
        correct = false;
        errorMsg = errorMsg + "\n" + "* הסיסמה צריכה להכיל לפחות ספרה אחת";
    }
    if (capitalLetters == 0) {
        correct = false;
        errorMsg = errorMsg + "\n" + "* הסיסמה צריכה להכיל לפחות אות אנגלית גדולה אחת";
    }
    if (smallLetters == 0) {
        correct = false;
        errorMsg = errorMsg + "\n" + "* הסיסמה צריכה לפחות אות אנגלית קטנה אחת";
    }
    
    return [correct, errorMsg];
}
//********************************************************************************************