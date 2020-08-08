class CashFlowController < ApplicationController
  def index
    incomes = income_per_month
    expenses = expenses_per_month
    cash_flow = group_incomes_expenses(incomes, expenses)
    send_success(cash_flow)
  end

  private

  def income_per_month
    t = Time.now
    date = Date.new(t.year-1, t.month)
    invoices = Invoice.where({created_at: date..(date+11.month)})
    invoices.reduce({}) do |hash, invoice|
      hash_date = invoice.created_at.to_date
      date_invoice = "#{hash_date.year}-#{hash_date.month}"
      value = invoice.get_invoice_value
      hash[date_invoice][value['currency_type']] = hash[date_invoice][value['currency_type']] ?  hash[date_invoice][value['currency_type']] + value[]: 0
      hash
    end
  end

  def expenses_per_month
    t = Time.now
    date = Date.new(t.year-1, t.month)
    expenses = Expense.where({created_at: date..(date+11.month)})
    expenses.reduce(Hash.new(0)) do |hash, expense|
      hash_date = expense.created_at.to_date
      hash["#{hash_date.year}-#{hash_date.month}"] +=2
    end
  end

  def group_incomes_expenses(incomes, expenses)
    t = Time.now
    date = Date.new(t.year-1, t.month)
    (0..11).reduce({}) do |hash,n|
      target_date = date+n.month
      format_date = "#{target_date.year}-#{target_date.month}".to_sym
      hash[format_date] = {} if incomes[format_date] || expenses[format_date]
      hash[format_date][:incomes] = incomes[format_date] if incomes[format_date]
      hash[format_date][:expenses] = expenses[format_date] if expenses[format_date]
      hash
    end
  end
end
