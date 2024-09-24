-- Create the database car_accident_staging_db
CREATE DATABASE car_accident_staging_db;

-- Use the newly created database
USE car_accident_staging_db;

-- Create table: caracteristics
CREATE TABLE caracteristics (
    Num_Acc VARCHAR(45),
    an VARCHAR(45),
    mois VARCHAR(45),
    jour VARCHAR(45),
    hrmn VARCHAR(45),
    lum VARCHAR(45),
    agg VARCHAR(45),
    inter VARCHAR(45),
    atm VARCHAR(45),
    col VARCHAR(45),
    com VARCHAR(45),
    adr VARCHAR(45),
    gps VARCHAR(45),
    lat VARCHAR(45),
    longi VARCHAR(45),
    dep VARCHAR(45)
);

-- Create table: places
CREATE TABLE places (
    Num_Acc VARCHAR(45),
    catr VARCHAR(45),
    voie VARCHAR(45),
    v1 VARCHAR(45),
    v2 VARCHAR(45),
    circ VARCHAR(45),
    nbv VARCHAR(45),
    pr VARCHAR(45),
    pr1 VARCHAR(45),
    vosp VARCHAR(45),
    prof VARCHAR(45),
    plan VARCHAR(45),
    lartpc VARCHAR(45),
    larout VARCHAR(45),
    surf VARCHAR(45),
    infra VARCHAR(45),
    situ VARCHAR(45),
    env1 VARCHAR(45)
);

-- Create table: users
CREATE TABLE users (
    Num_Acc VARCHAR(45),
    place VARCHAR(45),
    catu VARCHAR(45),
    grav VARCHAR(45),
    sexe VARCHAR(45),
    trajet VARCHAR(45),
    secu VARCHAR(45),
    locp VARCHAR(45),
    actp VARCHAR(45),
    etatp VARCHAR(45),
    an_nais VARCHAR(45),
    num_veh VARCHAR(45)
);

-- Create table: vehicles
CREATE TABLE vehicles (
    Num_Acc VARCHAR(45),
    senc VARCHAR(45),
    catv VARCHAR(45),
    occutc VARCHAR(45),
    obs VARCHAR(45),
    obsm VARCHAR(45),
    choc VARCHAR(45),
    manv VARCHAR(45),
    num_veh VARCHAR(45)
);

-- Create table: weatherdata
CREATE TABLE weatherdata (
    Date TEXT,
    Region TEXT,
    Temperature DOUBLE,
    Humidity BIGINT,
    Wind_Speed DOUBLE,
    Precipitation DOUBLE,
    Visibility BIGINT,
    Weather_Condition TEXT,
    Pressure DOUBLE,
    Sunshine_Duration DOUBLE
);
