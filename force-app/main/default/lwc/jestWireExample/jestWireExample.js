import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/JestWireExample.getAcctList';


export default class JestWireExample extends LightningElement {
    @wire(getAccounts)
	accounts;
}