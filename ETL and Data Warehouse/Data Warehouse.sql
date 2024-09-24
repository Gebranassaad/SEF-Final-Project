CREATE DATABASE car_accident_dwh;

use car_accident_dwh;

DROP TABLE IF EXISTS users_dm;
DROP TABLE IF EXISTS fact_table;

-- Drop the supporting tables
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS characteristic_lighting;
DROP TABLE IF EXISTS characteristic_intersection;
DROP TABLE IF EXISTS characteristic_collision;
DROP TABLE IF EXISTS places_situation;
DROP TABLE IF EXISTS places_category;
DROP TABLE IF EXISTS places_traffic;
DROP TABLE IF EXISTS places_lane;
DROP TABLE IF EXISTS places_profile;
DROP TABLE IF EXISTS places_plan;
DROP TABLE IF EXISTS places_surface;

-- Drop user-related supporting tables
DROP TABLE IF EXISTS users_category;
DROP TABLE IF EXISTS users_severity;
DROP TABLE IF EXISTS users_reason;
DROP TABLE IF EXISTS users_safety_existence;
DROP TABLE IF EXISTS users_safety_use;
DROP TABLE IF EXISTS vehicles_category;


-- User Category Table
CREATE TABLE users_category (
    catu INT PRIMARY KEY,
    Category VARCHAR(50)
);

-- Severity Level Table
CREATE TABLE users_severity (
    grav INT PRIMARY KEY,
    Severity VARCHAR(50)
);

-- Reason of Travelling Table
CREATE TABLE users_reason (
    trajet INT PRIMARY KEY,
    Reason VARCHAR(50)
);

-- Safety Existence Table
CREATE TABLE users_safety_existence (
    safety_existence INT PRIMARY KEY,
    Safety_Equipment VARCHAR(50)
);

-- Safety Use Table
CREATE TABLE users_safety_use (
    safety_use INT PRIMARY KEY,
    Used VARCHAR(50)
);

-- Vehicle Category Table
CREATE TABLE vehicles_category (
    catv INT PRIMARY KEY,
    Category VARCHAR(50)
);

-- Lighting Table
CREATE TABLE characteristic_lighting (
    lum INT PRIMARY KEY  ,
    Category VARCHAR(50)
);

-- Intersection Table
CREATE TABLE characteristic_intersection (
    inter INT PRIMARY KEY ,
    Category VARCHAR(50)
);

-- Collision Table
CREATE TABLE characteristic_collision (
    col INT PRIMARY KEY ,
    Category VARCHAR(50)
);

CREATE TABLE places_situation (
    situ INT PRIMARY KEY,
    Situation VARCHAR(100)
);

-- Place Category Table
CREATE TABLE places_category (
    catr INT PRIMARY KEY ,
    Category VARCHAR(50)
);

-- Traffic Regime Table
CREATE TABLE places_traffic (
    circ INT PRIMARY KEY ,
    Traffic VARCHAR(50)
);

-- Reserved Lane Table
CREATE TABLE places_lane (
    vosp INT PRIMARY KEY ,
    Lane VARCHAR(50)
);

-- Road Profile Table
CREATE TABLE places_profile (
    prof INT PRIMARY KEY ,
    profile VARCHAR(50)
);

-- Drawing Plan Table
CREATE TABLE places_plan (
    plan INT PRIMARY KEY ,
    DrawingPlan VARCHAR(50)
);

-- Surface Condition Table
CREATE TABLE places_surface (
    surf INT PRIMARY KEY ,
    Surface VARCHAR(50)
);

-- Weather Table with composite primary key
CREATE TABLE weather (
    date DATE ,
    region VARCHAR(100) ,
    temperature_C FLOAT,
    humidity_Percent INT,
    wind_Speed_m_s FLOAT,
    precipitation_mm FLOAT,
    visibility_meters INT,
    weather_Condition VARCHAR(50),
    pressure_hPa FLOAT,
    sunshine_Duration_hours FLOAT,
    PRIMARY KEY (date, region)
);

-- Fact Table
CREATE TABLE fact_table (
    Num_Acc VARCHAR(255) ,
    date DATE ,
    region VARCHAR(100) ,
    hour INT,
    dep INT,
    Country VARCHAR(255),
    lum INT ,
    inter INT,
    col INT,
    catr INT,
    circ INT,
    vosp INT,
    prof INT,
    plan INT,
    surf INT,
    situ INT,
    temperature_C FLOAT,
    visibility_meters FLOAT,
    weather_Condition VARCHAR(50),
    longitude FLOAT,
    latitude FLOAT,
    weather_Conditions_UK VARCHAR(255),
    PRIMARY KEY (Num_Acc),

    -- Foreign Keys
    FOREIGN KEY (lum) REFERENCES characteristic_lighting(lum),
    FOREIGN KEY (inter) REFERENCES characteristic_intersection(inter),
    FOREIGN KEY (col) REFERENCES characteristic_collision(col),
    FOREIGN KEY (situ) REFERENCES places_situation(situ),
    FOREIGN KEY (catr) REFERENCES places_category(catr),
    FOREIGN KEY (circ) REFERENCES places_traffic(circ),
    FOREIGN KEY (vosp) REFERENCES places_lane(vosp),
    FOREIGN KEY (prof) REFERENCES places_profile(prof),
    FOREIGN KEY (plan) REFERENCES places_plan(plan),
    FOREIGN KEY (surf) REFERENCES places_surface(surf),

    -- Composite Foreign Key for weather (date, region)
    FOREIGN KEY (date, region) REFERENCES weather(date, region)
);



-- Users Dm Table
CREATE TABLE users_dm (
    user_id INT PRIMARY KEY,
    Num_Acc VARCHAR(255)  ,
    catu INT,
    grav INT,
    sexe INT,
    trajet INT,
    an_nais INT,
    num_veh VARCHAR(255),
    safety_existence INT,
    safety_use INT,
    catv INT,
    car_condition VARCHAR(255),
    wheels_condition VARCHAR(255),
    vehicle_company VARCHAR(255),
    speed INT,
    age INT,
    survival_rate FLOAT,

    -- Foreign Keys
    FOREIGN KEY (Num_Acc) REFERENCES fact_table(Num_Acc),
    FOREIGN KEY (catu) REFERENCES users_category(catu),
    FOREIGN KEY (grav) REFERENCES users_severity(grav),
    FOREIGN KEY (trajet) REFERENCES users_reason(trajet),
    FOREIGN KEY (catv) REFERENCES vehicles_category(catv),
    FOREIGN KEY (safety_existence) REFERENCES users_safety_existence(safety_existence),
    FOREIGN KEY (safety_use) REFERENCES users_safety_use(safety_use)
);

-- Drop fact_table (it references multiple tables)
DROP TABLE IF EXISTS users_dm;
DROP TABLE IF EXISTS fact_table;

-- Drop the supporting tables
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS characteristic_lighting;
DROP TABLE IF EXISTS characteristic_intersection;
DROP TABLE IF EXISTS characteristic_collision;
DROP TABLE IF EXISTS places_situation;
DROP TABLE IF EXISTS places_category;
DROP TABLE IF EXISTS places_traffic;
DROP TABLE IF EXISTS places_lane;
DROP TABLE IF EXISTS places_profile;
DROP TABLE IF EXISTS places_plan;
DROP TABLE IF EXISTS places_surface;

-- Drop user-related supporting tables
DROP TABLE IF EXISTS users_category;
DROP TABLE IF EXISTS users_severity;
DROP TABLE IF EXISTS users_reason;
DROP TABLE IF EXISTS users_safety_existence;
DROP TABLE IF EXISTS users_safety_use;
DROP TABLE IF EXISTS vehicles_category;

