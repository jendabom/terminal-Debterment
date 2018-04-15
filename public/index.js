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
    axios.get("http://localhost:3000/expenses").then(function(response) {
      this.expenses = response.data;
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var AddExpensePage = {
  template: "#add-expense-page",
  data: function() {
    return {
      message: "Enter a New Expense!", 
      expenses: [],
      newExpense: {name: "", monthly_payment: 0, expense_type: ""}
    };
  },
  created: function() {
    axios.get("http://localhost:3000/expenses").then(function(response) {
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
        this.newExpense = {name: "", monthly_payment: 0, expense_type: ""};
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
    axios.get("http://localhost:3000/incomes").then(function(response) {
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
      message: "Welcome to Debterment!", 
      debts: [],
      newDebt: {name: "", total_balance: 0, apr: 0, min_amount_due: 0, due_date: "", debt_type: "", card_limit: 0}
    };
  },
  created: function() {
    axios.get("http://localhost:3000/debts").then(function(response) {
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
    axios.get("http://localhost:3000/debts").then(function(response) {
      this.debts = response.data;
    }.bind(this));
  },
  methods: {
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
    axios.get("http://localhost:3000/snowball").then(function(response) {
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
    axios.get("http://localhost:3000/avalanche").then(function(response) {
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
      message: "Welcome to Debterment!", 
    };
  },
  created: function() {

  },
  methods: {},
  computed: {}
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
    { path: "/add_expense", component: AddExpensePage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});