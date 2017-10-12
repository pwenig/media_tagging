import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'select-component',
  template: `
    <label for="{{label}}">{{label}}</label>
    <select class="form-control" id="{{label}}" required (change)="optionSelected()" [(ngModel)]="chosenOption">
    <option disabled hidden [value]="placeholder">Select {{label}}</option>
    <option *ngFor="let option of options" [ngValue]="option">{{option.name}}</option>
  `
})

export class SelectComponent {
  @Input() label: string;
  @Input() options: any;
  @Output() selected = new EventEmitter();

  private chosenOption: any;
  private placeholder: any;

  optionSelected() {
    this.selected.emit(this.chosenOption);
  }
}