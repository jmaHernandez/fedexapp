import { Component, OnInit } from '@angular/core';

// Services
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent implements OnInit {
  packages: any[] = []

  constructor(private api: ApiService) { }

  ngOnInit() {
    this.api.getPackages().subscribe(res => {
      this.packages = res;
    })
  }

}
