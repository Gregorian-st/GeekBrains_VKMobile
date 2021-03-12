import UIKit

protocol Coffee {
    // Cost in cents
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int {
        return 100
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class WithMilk: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 50
    }
}

class WithWhip: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 90
    }
}

class WithSugar: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 40
    }
}

class WithSyrup: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 50
    }
}

class WithWater: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 20
    }
}

let simpleCoffee = SimpleCoffee()

let americano = WithWater(base: simpleCoffee)
print("Americano cost is $\(Double(americano.cost)/100)")

let cappuccino = WithSugar(base: WithMilk(base: WithMilk(base: WithWhip(base: simpleCoffee))))
print("Cappuccino cost is $\(Double(cappuccino.cost)/100)")

let rafCoffee = WithSyrup(base: WithWhip(base: simpleCoffee))
print("Raf coffee cost is $\(Double(rafCoffee.cost)/100)")
