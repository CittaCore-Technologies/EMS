import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    paragraphText = "Hi I'm a Talapia";
	renderImage = false;
	tacoList = [{Id:'1', TacoType:'Chalupa'}, {Id:'2', TacoType: 'Crunchy'}];
        //JS variable we've added to pass to the child component
	turtleInfo = 'Turtles are so magical';

	changePText(){
		this.paragraphText = "Hi I'm a taco";	
	}
}