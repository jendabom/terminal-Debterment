/* global Vue, VueRouter, axios */
var ExpensePage = {
  template: '#expense-page',
  data: function() {
    return {
      message: "Show the expenses", 
      expenses: []
    };
  },
  created: function() {
    axios.get("/expenses").then(function(response) {
      this.expenses = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var AddIncomePage = {
  template: "#add-income-page",
  data: function() {
    return {
      message: "Enter a New Income!", 
      incomes: [],
      newIncome: {name: "", paydays_per_year: 0, amount_per_payday: 0, recurring: ""}
    };
  },
  created: function() {
    axios.get("/incomes").then(function(response) {
      this.incomes = response.data;
    }.bind(this));
  },
  methods: {
    addIncome: function() {
      var params = {
        name: this.newIncome.name,
        paydays_per_year: this.newIncome.paydays_per_year, 
        amount_per_payday: this.newIncome.amount_per_payday, 
        recurring: this.newIncome.recurring
      };

      axios.post("/incomes", params).then(function(response) {
        this.incomes.push(response.data);
        this.newIncome = {name: "", paydays_per_year: 0, amount_per_payday: 0, recurring: ""};
      }.bind(this));
    }
  },
  computed: {}
};

var AddExpensePage = {
  template: "#add-expense-page",
  data: function() {
    return {
      message: "Enter a New Expense!", 
      expenses: [],
      newExpense: {name: "", monthly_payment: 0, expense_type: "", need: true}
    };
  },
  created: function() {
    axios.get("/expenses").then(function(response) {
      this.expenses = response.data;
    }.bind(this));
  },
  methods: {
    addExpense: function() {
      var params = {
        name: this.newExpense.name,
        monthly_payment: this.newExpense.monthly_payment, 
        expense_type: this.newExpense.expense_type
      };

      axios.post("/expenses", params).then(function(response) {
        this.expenses.push(response.data);
        this.newExpense = {name: "", monthly_payment: 0, expense_type: "", need: true};
      }.bind(this));
    }
  },
  computed: {}
};

var IncomePage = {
  template: '#income-page',
  data: function() {
    return {
      message: "Show the Income", 
      incomes: []
    };
  },
  created: function() {
    axios.get("/incomes").then(function(response) {
      this.incomes = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var AddDebtPage = {
  template: "#add-debt-page",
  data: function() {
    return {
      message: "Add a Debt", 
      debts: [],
      newDebt: {name: "", total_balance: 0, apr: 0, min_amount_due: 0, due_date: "", debt_type: "", card_limit: 0}
    };
  },
  created: function() {
    axios.get("/debts").then(function(response) {
      this.debts = response.data;
    }.bind(this));
  },
  methods: {
    addDebt: function() {
      var params = {
        name: this.newDebt.name,
        total_balance: this.newDebt.total_balance, 
        apr: this.newDebt.apr,
        min_amt_due: this.newDebt.min_amt_due,
        due_date: this.newDebt.due_date,
        debt_type: this.newDebt.debt_type, 
        card_limit: this.newDebt.card_limit
      };

      axios.post("/debts", params).then(function(response) {
        this.debts.push(response.data);
        this.newDebt = {name: "", total_balance: 0, apr: 0, min_amount_due: 0, due_date: "", debt_type: "", card_limit: 0};
      }.bind(this));
    }
  },
  computed: {}
};

var DebtPage = {
  template: "#debt-page",
  data: function() {
    return {
      message: "Welcome to Debterment!", 
      debts: []
    };
  },
  created: function() {
    axios.get("/debts").then(function(response) {
      this.debts = response.data;
    }.bind(this));
  },
  methods: {
  },
  computed: {}
};

var AllDebtPage = {
  template: "#all-debt-page",
  data: function() {
    return {
      message: "Outstanding Debts:", 
      debts: [],
      showall:[], 
      first_debt: "", 
      second_debt: ""
    };
  },
  created: function() {
    axios.get("/alldebts").then(function(response) {
      this.debts = response.data;
      this.first_debt = this.debts[0]
      this.second_debt = this.debts[1]
      console.log(this.debts)
    }.bind(this));
    axios.get("/showall").then(function(response) {
      console.log(response.data);
      this.showall = response.data;
    }.bind(this));
  },
  methods: {
  },
  computed: {}
};

var MonthlyPlanningPage = {
  template: "#monthly-planning-page",
  data: function() {
    return {
      message: "Payoff Plan!", 
      debts: [],
      showall:  []
    };
  },
  created: function() {
    axios.get("/monthly_payoff").then(function(response) {
      this.debts = response.data;
      console.log(this.debts);
    }.bind(this));
    axios.get("/showall").then(function(response) {
      console.log(response.data);
      this.showall = response.data;
    }.bind(this));
  },
  methods: {
    payDown: function() {
      console.log("updating the debt ....");
      for (let i = 0; i < this.debts.length; i++) {
        console.log(this.debts[i].min_amt_due);
      }
    }
  },
  computed: {}
};

var SnowballDebtPage = {
  template: "#snowball-page",
  data: function() {
    return {
      message: "Snowball Payoff Schedule!", 
      debts: []
    };
  },
  created: function() {
    axios.get("/snowball").then(function(response) {
      this.debts = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var AvalancheDebtPage = {
  template: "#avalanche-page",
  data: function() {
    return {
      message: "Avalanche Payoff Schedule!", 
      debts: []
    };
  },
  created: function() {
    axios.get("/avalanche").then(function(response) {
      this.debts = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      greeting: "Welcome to Debterment!",
      message: "Get your life back and tell your debt to go bye bye!",
      showall: [] 
    };
  },
  created: function() {
    axios.get("/showall").then(function(response) {
      console.log(response.data);
      this.showall = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var UserSettingsPage = {
  template: "#user-settings-page",
  data: function() {
    return {
      message: "User Settings"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        last_name: this.last_name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/all_debts");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/my_expenses", component: ExpensePage },
    { path: "/my_debts", component: DebtPage },
    { path: "/my_incomes", component: IncomePage },
    { path: "/my_snowball", component: SnowballDebtPage },
    { path: "/my_avalanche", component: AvalancheDebtPage },
    { path: "/add_debt", component: AddDebtPage },
    { path: "/add_expense", component: AddExpensePage }, 
    { path: "/add_income", component: AddIncomePage }, 
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage }, 
    { path: "/logout", component: LogoutPage }, 
    { path: "/all_debts", component: AllDebtPage },
    { path: "/payoff_plan", component: MonthlyPlanningPage },
    { path: "/settings", component: UserSettingsPage }    
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});