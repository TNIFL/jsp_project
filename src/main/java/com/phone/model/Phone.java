package com.phone.model;

public class Phone {
    private int phoneId;		 	// 휴대폰 ID (primary key)
    private int yearOfRelease;   	// 출시 연도
    private int price;           	// 원화 (KRW)
    private int storage;         	// GB
    private int ram;             	// GB
    private int battery;         	// mAh
    private double displayInch;  	// 인치
    private double weight;       	// g

    private String brand;			// 제조사
    private String model;	 		// 모델명
    private String processor;	 	// 칩셋 정보
    private String displayInfo;  	// 해상도, 패널 정보 등
    private String cameraInfo;	 	// 카메라 사양
    private String connectivity; 	// 5G, Wi-Fi 6 등
    private String specialFeatures;	// 폴더블 등 특수 기능
    private String size;         	// "153.9×67.1×7.6" 등 문자열 형태

	// 기본 생성자
    public Phone() {}

    // 생성자
    public Phone(int phoneId, int yearOfRelease, int price, int storage, int ram, int battery,
                 double displayInch, double weight, 
                 String brand, String model, String processor, String displayInfo, String cameraInfo, String connectivity, String specialFeatures, String size) {
        this.phoneId = phoneId;
        this.yearOfRelease = yearOfRelease;
        this.price = price;
        this.storage = storage;
        this.ram = ram;
        this.battery = battery;
        this.displayInch = displayInch;
        this.weight = weight;
        this.brand = brand;
        this.model = model;
        this.processor = processor;
        this.displayInfo = displayInfo;
        this.cameraInfo = cameraInfo;
        this.connectivity = connectivity;
        this.specialFeatures = specialFeatures;
        this.size = size;
    }

    // Getters and Setters
    public int getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }

    public int getYearOfRelease() {
        return yearOfRelease;
    }

    public void setYearOfRelease(int yearOfRelease) {
        this.yearOfRelease = yearOfRelease;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getStorage() {
        return storage;
    }

    public void setStorage(int storage) {
        this.storage = storage;
    }

    public int getRam() {
        return ram;
    }

    public void setRam(int ram) {
        this.ram = ram;
    }

    public int getBattery() {
        return battery;
    }

    public void setBattery(int battery) {
        this.battery = battery;
    }

    public double getDisplayInch() {
        return displayInch;
    }

    public void setDisplayInch(double displayInch) {
        this.displayInch = displayInch;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getProcessor() {
        return processor;
    }

    public void setProcessor(String processor) {
        this.processor = processor;
    }

    public String getDisplayInfo() {
        return displayInfo;
    }

    public void setDisplayInfo(String displayInfo) {
        this.displayInfo = displayInfo;
    }

    public String getCameraInfo() {
        return cameraInfo;
    }

    public void setCameraInfo(String cameraInfo) {
        this.cameraInfo = cameraInfo;
    }

    public String getConnectivity() {
        return connectivity;
    }

    public void setConnectivity(String connectivity) {
        this.connectivity = connectivity;
    }

    public String getSpecialFeatures() {
        return specialFeatures;
    }

    public void setSpecialFeatures(String specialFeatures) {
        this.specialFeatures = specialFeatures;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

}
