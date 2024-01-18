import { LightningElement } from 'lwc';
import getCases from '@salesforce/apex/JestApexCallExample.getKewlCases';

export default class JestApexCallExample extends LightningElement {
    cases;
        errors;

	connectedCallback() {
		this.getCasesToDisplay();
	}

	getCasesToDisplay(){
		getCases({'subject':'kewl case'}).then(result=>{
			this.cases = result;
		}).catch(error=>{
                        this.errors = error;
		});
	}
}