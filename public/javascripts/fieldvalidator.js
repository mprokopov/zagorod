// FieldValidator Class v1
// Author:    Serge I. Zolotukhin ( serge@design.ru, http://serge.design.ru/ )
// Updated:   2003-04-25

// Поддерживается работа с элементами: INPUT/TEXT | INPUT/PASSWORD | INPUT/CHECKBOX | INPUT/FILE | SELECT | TEXTAREA

/*
 * Constructor
 */
function FieldValidator(sName,sMode,pAfterValidation,pBeforeValidation,sRegExp)
{
	var oSelf = this

	// Если ни одного элемента с заданным именем не найдено, throw exception
	var aNodes = document.getElementById(sName)
	if( !aNodes ) throw sName
	//this.oFieldNode = aNodes.item(0)
	this.oFieldNode = aNodes

	// Если у элемента нет формы, throw exception
	if( !this.oFieldNode.form ) throw 2

	// Режим проверки
	this.sMode = sMode ? sMode : 'RequiredField'

	// Регулярное выражение для режима проверки RegExp
	if( sRegExp ) this.oRegExp = new RegExp( sRegExp )

	// Обработчик формы
	this.SetupEvent( this.oFieldNode.form, 'submit', function(e){ return oSelf.Validator(e) } )

	// Статус "правильности поля"
	this.bValidated = false

	// Функция, вызываемая перед проверкой
	this.BeforeValidation = pBeforeValidation ? pBeforeValidation : function(){}

	// Функция, вызываемая после проверки
	this.AfterValidation = pAfterValidation ? pAfterValidation : this.AfterValidationDefault

	return this
} 

// Проверка поля в режиме RequiredField. e -- событие submit.
FieldValidator.prototype.Validator = function(e)
{
	this.BeforeValidation()

	// Проверим правильным валидатором в зависимости от режима проверки
	switch( this.sMode )
	{
		case 'RequiredField' : this.bValidated = this.RequiredFieldValidator(); break;
		case 'RegExp'        : this.bValidated = this.RegExpValidator();        break;
		case 'Email'         : this.bValidated = this.EmailValidator();         break;
		case 'Int'           : this.bValidated = this.IntValidator();           break;
		case 'Float'         : this.bValidated = this.FloatValidator();         break;
		default              : this.bValidated = false
	}
	// Придушить событие submit у формы если поля не заполнены...
	if( !this.bValidated ) this.KillEvent(e)

	this.AfterValidation()
}

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Валидаторы
 */

// RequiredField
FieldValidator.prototype.RequiredFieldValidator = function()
{
	return (
		( this.oFieldNode.type != 'checkbox' && this.oFieldNode.value != '' ) ||
		( this.oFieldNode.type == 'checkbox' && this.oFieldNode.checked )
	)
}

// RegExp
FieldValidator.prototype.RegExpValidator = function()
{
	return ( this.oFieldNode.type != 'checkbox' && this.oRegExp.test( this.oFieldNode.value ) )
}

// Email
FieldValidator.prototype.EmailValidator = function()
{
	var sEmail = this.oFieldNode.value.replace( new RegExp('/\(.*?\)/'), '' )
	var oRegExp = /^[A-Za-z0-9][-\w]*(\.[A-Za-z0-9][-\w]*)*@[A-Za-z0-9][-\w]*(\.[A-Za-z0-9][-\w]*)*\.[a-zA-Z]{2,4}$/
	return oRegExp.test(sEmail)
}

// Int
FieldValidator.prototype.IntValidator = function()
{
	return ( parseInt(this.oFieldNode.value) == this.oFieldNode.value )
}

// Float
FieldValidator.prototype.FloatValidator = function()
{
	return ( parseFloat(this.oFieldNode.value) == this.oFieldNode.value )
}

/* 
 * Валидаторы
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

// Функция AfterValidation по умолчанию
FieldValidator.prototype.AfterValidationDefault = function()
{
	if( !this.bValidated )
	{
		alert(
			'ВНИМАНИЕ!\n' +
			'Одно из полей формы заполнено неверно!\n\n' +
			'---\n' +
			'Field ' + this.oFieldNode.name + ' has validated as ' + this.sMode
		)
	}
}

// Приделываем обработчик события
FieldValidator.prototype.SetupEvent = function( oElement, sEventType, pHandler )
{
	if( oElement.attachEvent ) oElement.attachEvent('on' + sEventType, pHandler)
	if( oElement.addEventListener ) oElement.addEventListener(sEventType, pHandler, false)
}


// Замочить текущее событие
FieldValidator.prototype.KillEvent = function(e)
{
	var oEvent = e ? e : window.event
	if( oEvent.preventDefault )
	{
		oEvent.preventDefault()
	}
	else
	{
		oEvent.returnValue = false
	}
}
