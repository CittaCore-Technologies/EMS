import { LightningElement } from 'lwc';

export default class JestDataBindExampleWithConditionalRendering extends LightningElement {
    paragraphText = "Hi I'm a Talapia";
	renderImage = false;
	tacoList = [{Id:'1', TacoType:'Chalupa'}, {Id:'2', TacoType: 'Crunchy'}];
	changePText(){
		this.paragraphText = "Hi I'm a taco";	
	}
}