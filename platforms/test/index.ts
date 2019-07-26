import { TestRunner } from './src/TestRunner'

declare const KARMA_HOST: string
declare const KARMA_PORT: string

const runner = new TestRunner(KARMA_HOST, KARMA_PORT)