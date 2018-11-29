import { Component } from '@angular/core';

import { Http } from '@angular/http';

import 'rxjs/add/operator/map';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';

  constructor(private http: Http) {
  	this.testAPI();
  }

  testAPI() {
  	this.http.get('/api/v1/pages')
  	.map(res => res.json())
  	.subscribe(
  		res => {
			console.log(res);
        }
    );
  }
}
