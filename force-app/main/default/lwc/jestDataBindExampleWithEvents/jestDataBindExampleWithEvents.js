import { LightningElement } from 'lwc';

export default class JestDataBindExampleWithEvents extends LightningElement {

	paragraphText = "Hi I'm a Talapia";

	changePText(){
		this.paragraphText = "Hi I'm a taco";	
	}
}