<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard</title>
    <!-- set up google icon fonts -->
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <link rel="stylesheet" href="./css/dashboard.css" />
  </head>

  <body>
    <div class="container">
      <aside>
        <div class="top">
          <div class="logo">
            <img src="./img/dashboard/수박.jpeg" alt="" />
            <h2 class="title">
              <span class="success">Dash</span>board
            </h2>
          </div>
          <div id="close-btn" class="close">
            <span class="material-symbols-sharp">close</span>
          </div>
        </div>

        <!-- -------------------sidebar------------------- -->
        <div class="sidebar">
          <a href="#">
            <span class="material-icons-sharp">grid_view</span>
            <h3>Dashboard</h3>
          </a>
          <a href="#" class="active">
            <span class="material-icons-sharp">person_outline</span>
            <h3>Customers</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">receipt_long</span>
            <h3>Orders</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">insights</span>
            <h3>Analytics</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">mail_outline</span>
            <h3>Messages</h3>
            <span class="massage-count">26</span>
          </a>
          <a href="#">
            <span class="material-icons-sharp">inventory</span>
            <h3>Products</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">report_gmailerrorred</span>
            <h3>Reports</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">add</span>
            <h3>Add Product</h3>
          </a>
          <a href="#">
            <span class="material-icons-sharp">logout</span>
            <h3>Logout</h3>
          </a>
        </div>
      </aside>
      <!-- -------------------end of aside------------------- -->
      <main>
        <h1>Dashboard</h1>

        <div class="date">
          <input type="date" />
        </div>
        <div class="insights">
          <div class="sales">
            <span class="material-icons-sharp">analytics</span>
            <div class="middle">
              <div class="left">
                <h3>Total Sales</h3>
                <h1>$25,024</h1>
              </div>
              <div class="progress">
                <svg>
                  <circle cx="38" cy="38" r="38"></circle>
                </svg>
                <div class="number">
                  <p>81%</p>
                </div>
              </div>
            </div>
            <small class="text-muted">Last 24 Hours</small>
          </div>
          <!-- -------------------end of sales------------------- -->
          <div class="expenses">
            <span class="material-icons-sharp">bar_chart</span>
            <div class="middle">
              <div class="left">
                <h3>Total Expenses</h3>
                <h1>$14,160</h1>
              </div>
              <div class="progress">
                <svg>
                  <circle cx="38" cy="38" r="38"></circle>
                </svg>
                <div class="number">
                  <p>62%</p>
                </div>
              </div>
            </div>
            <small class="text-muted">Last 24 Hours</small>
          </div>
          <!-- -------------------end of expenses------------------- -->
          <div class="income">
            <span class="material-icons-sharp">stacked_line_chart</span>
            <div class="middle">
              <div class="left">
                <h3>Total Income</h3>
                <h1>$10,864</h1>
              </div>
              <div class="progress">
                <svg>
                  <circle cx="38" cy="38" r="38"></circle>
                </svg>
                <div class="number">
                  <p>44%</p>
                </div>
              </div>
            </div>
            <small class="text-muted">Last 24 Hours</small>
          </div>
          <!-- -------------------end of income------------------- -->
        </div>
        <!-- -------------------end of insights------------------- -->

        <div class="recent-orders">
          <h2>Recent Orders</h2>
          <table>
            <thead>
              <tr>
                <th>Product Name</th>
                <th>Product Number</th>
                <th>Payment</th>
                <th>Statue</th>
                <th></th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
          <a href="#">Show All</a>
        </div>
      </main>
      <!-- -------------------end of main------------------- -->

      <div class="right">
        <div class="top">
          <button id="menu-btn">
            <span class="material-icons-sharp">menu</span>
          </button>
          <div class="theme-toggler">
            <span class="material-icons-sharp active">light_mode</span>
            <span class="material-icons-sharp">dark_mode</span>
          </div>
          <div class="profile">
            <div class="info">
              <p>Hey, <b>Minju</b></p>
              <small class="text-muted">Admin</small>
            </div>
            <div class="profile-photo">
              <img src="./img/dashboard/셔틀콕.jpeg" alt="" />
            </div>
          </div>
        </div>
        <!-- -------------------end of top------------------- -->

        <div class="recent-updates">
          <h2>Recent Updates</h2>
          <div class="updates">
            <div class="update">
              <div class="profile-photo">
                <img src="./img/dashboard/바나나.jpeg" alt="" />
              </div>
              <div class="message">
                <p>
                  <b>Kang minju</b> received his order of Night lion tech GPS
                  drone.
                </p>
                <small class="text-muted">2 Munutes Ago</small>
              </div>
            </div>
            <div class="update">
              <div class="profile-photo">
                <img src="./img/dashboard/포도.jpeg" alt="" />
              </div>
              <div class="message">
                <p><b>Lina</b> declined her order of 2 DJI Air 2S.</p>
                <small class="text-muted">5 Munutes Ago</small>
              </div>
            </div>
          </div>
        </div>
        <!-- -------------------end of recent updates------------------- -->
        <div class="sales-analytics">
          <h2>Sales Analytics</h2>
          <div class="item online">
            <div class="icon">
              <span class="material-icons-sharp">shopping_cart</span>
            </div>
            <div class="right">
              <div class="info">
                <h3>ONLINE ORDERS</h3>
                <small class="text-muted">Last 24 Hours</small>
              </div>
              <h5 class="success">+39%</h5>
              <h3>3849</h3>
            </div>
          </div>
          <div class="item offline">
            <div class="icon">
              <span class="material-icons-sharp">local_mall</span>
            </div>
            <div class="right">
              <div class="info">
                <h3>OFFLINE ORDERS</h3>
                <small class="text-muted">Last 24 Hours</small>
              </div>
              <h5 class="danger">-17%</h5>
              <h3>1100</h3>
            </div>
          </div>
          <div class="item customers">
            <div class="icon">
              <span class="material-icons-sharp">person</span>
            </div>
            <div class="right">
              <div class="info">
                <h3>NEW CUSTOMERS</h3>
                <small class="text-muted">Last 24 Hours</small>
              </div>
              <h5 class="success">+25%</h5>
              <h3>849</h3>
            </div>
          </div>
          <div class="item add-product">
            <div>
              <span class="material-icons-sharp">add</span>
              <h3>Add Product</h3>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- script 불러오는 순서 중요! order가 밑으로 가면 orders를 못 불러옴-->
    <script src="./js/orders.js"></script>
    <script src="./js/dashboard.js"></script>
  </body>
</html>
