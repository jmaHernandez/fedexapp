import { Component } from '@angular/core';

// Services
import { ApiService } from './services/api.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';

  constructor(private api: ApiService) {
  	// this.testAPI();
  }

  testAPI() {
  	this.api.testAPI().subscribe(res => {
			console.log(res);
    });
  }
}
