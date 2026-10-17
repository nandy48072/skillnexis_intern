class Vehicle {
    protected String brand;
    protected int year;

    public Vehicle(String brand, int year) {
        this.brand = brand;
        this.year = year;
    }

    public void startEngine() {
        System.out.println(brand + " vehicle engine is starting.");
    }
}

class Car extends Vehicle {
    private int doors;

    public Car(String brand, int year, int doors) {
        super(brand, year);
        this.doors = doors;
    }

    @Override
    public void startEngine() { // Overriding the base class method
        System.out.println("Car (" + brand + " " + year + ", " + doors + " doors) engine roaring to life!");
    }
}
class Bike extends Vehicle {
    private boolean hasGear;

    public Bike(String brand, int year, boolean hasGear) {
        super(brand, year);
        this.hasGear = hasGear;
    }

    @Override
    public void startEngine() { // Overriding the base class method[cite: 11]
        System.out.println("Bike (" + brand + " " + year + ", Gear: " + hasGear + ") starting smoothly!");
    }
}

public class VehicleInheritance {
    public static void main(String[] args) {
        System.out.println("=== Vehicle Inheritance Example ===\n");

        Vehicle myCar = new Car("Toyota", 2023, 4);
        Vehicle myBike = new Bike("Yamaha", 2022, true);

        // Demonstrating method overriding[cite: 11]
        myCar.startEngine();
        myBike.startEngine();
    }
}