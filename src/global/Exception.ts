/**
 * @symbol CODE
 * @since 0.1.0
 */
export const CODE = Symbol('code')

/**
 * @symbol NAME
 * @since 0.4.0
 */
export const NAME = Symbol('name')

/**
 * @symbol MESSAGE
 * @since 0.4.0
 */
export const MESSAGE = Symbol('message')

export class Exception {


	public static create(code: Exception.Code, message?: string) {

		let name = ''

		switch (code) {
			case Exception.Code.InvalidStateError:
				name = 'The object is in an invalid state.'
				break
		}

		message = message || ''

		let exception = new Exception()
		exception[CODE] = code
		exception[NAME] = name
		exception[MESSAGE] = message

		return exception
	}

	public get code(): number {
		return this[CODE]
	}

	public get name(): string {
		return this[NAME]
	}

	public get message(): string {
		return this[MESSAGE]
	}

	constructor() {

	}

	private [CODE]: number = 0
	private [NAME]: string = ''
	private [MESSAGE]: string = ''

}

export module Exception {

	export enum Code {
		InvalidStateError = 11,
		SyntaxError = 12
	}

}