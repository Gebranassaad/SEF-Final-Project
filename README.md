<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>
This project is divided into three parts:


- **ETL**: A comprehensive pipeline for extracting, transforming, and loading road accident data from multiple sources to a centralized data warehouse.
- **Data Warehouse**: Designed and implemented a scalable data warehouse to store and manage accident-related data, enabling seamless integration with analysis tools and providing authorities with organized, reliable data to aid in accident prevention.
- **Analysis**: Power BI was utilized to analyze key factors contributing to road accidents, such as weather conditions, road types, and human behavior.

### User Stories
- As a user, I want to explore a Power BI report that visualizes road accident trends, so I can understand how different factors correlate with accident frequency.
- As a user, I want to filter the Power BI report by location, weather, and time, so I can focus on accident data relevant to my area of interest

<br><br>
<!-- Tech stack -->
<img src="./readme/title3.svg"/>

###  AcciTrack is built using the following technologies:

- **Python**: Python is responsible for the ETL (Extract, Transform, Load) process, automating data extraction from multiple sources, transforming it into an analyzable format, and preparing it for loading into the warehouse.
- **SQL**: SQL is used to efficiently load processed road accident data into the data warehouse, ensuring structured storage and easy access for future analysis and reporting.
- **Power BI**: Power BI is leveraged to create data visualizations and dashboards, allowing users to analyze accident trends, identify key contributing factors, and generate actionable insights to prevent future incidents.

<br><br>
<!-- UI UX 
<img src="./readme/title4.svg"/>
We designed Coffee Express using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.
Project Figma design [figma](https://www.figma.com/file/LsuOx5Wnh5YTGSEtrgvz4l/Purrfect-Pals?type=design&node-id=257%3A79&mode=design&t=adzbABt5hbb91ucZ-1)
### Mockups
| Home screen  | Menu Screen | Order Screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | -->

<br><br>

<!-- Data Warehouse Schema -->
<img src="./readme/title5.svg"/>

###  Architecting Data Excellence: Innovative Database Design Strategies:

- <img src="./readme/assets/Data Warehouse Schema.png"/>


<img src="./readme/title6.svg"/>



### User Screens (Power BI Report)
| Landing Page  | Accidents Over Time
| ---| ---| 
| <img src="./readme/assets/Landing%20Page.png"/> | ![fsdaf](./readme/assets/Accidents%20Over%20Time.png)
| Weather Analysis | France vs United Kingdom 
|<img src="./readme/assets/Weather Analysis.gif" /> |  ![Landing](./readme/demo/France%20and%20UK.gif)
| Road Analysis | Vehicle Condition |
| ![fsdaf](./readme/demo/Road%20Analysis.gif) | ![fsdaf](./readme/demo/Vehicle%20Condition.gif) |
| Key Influencers 1  | Key Influencers 2 |
| ![Landing](./readme/demo/Key%20Influencers%201.gif) | ![fsdaf](./readme/demo/Key%20Influencers%202.gif) |

<!-- Prompt Engineering 
<img src="./readme/title7.svg"/>

###  Mastering AI Interaction: Unveiling the Power of Prompt Engineering:

- This project uses advanced prompt engineering techniques to optimize the interaction with natural language processing models. By skillfully crafting input instructions, we tailor the behavior of the models to achieve precise and efficient language understanding and generation for various tasks and preferences.-->



<!-- AWS Deployment 
<img src="./readme/title8.svg"/>

###  Efficient AI Deployment: Unleashing the Potential with AWS Integration:

- This project leverages AWS deployment strategies to seamlessly integrate and deploy natural language processing models. With a focus on scalability, reliability, and performance, we ensure that AI applications powered by these models deliver robust and responsive solutions for diverse use cases. -->

<br><br>

<!-- Validation -->
<img src="./readme/title9.svg"/>

## Validation of Incremental and Full Loads for Fact and Dimension Tables

This project performs both **Incremental** and **Full Loads** for the data warehouse in different scenarios. Below is the detailed validation process for each of the procedures used.

### Incremental Load for Fact Table (car_accident_dwh.fact_table)

#### Inserting New Records:
The procedure first identifies new accident records from the staging database (`car_accident_staging_db.caracteristic`), which are not yet present in the fact table (`car_accident_dwh.fact_table`), and inserts them. This ensures that only new records are added.

A `LEFT JOIN` is used to compare the accident ID (`Num_Acc`) between staging and the data warehouse, and only records that are **not present** in the data warehouse are inserted.

#### Updating Existing Records:
Next, it updates any existing records in the fact table if there are more recent changes in the staging database. Only records where the staging data is newer than the current record in the fact table are updated.

The comparison is based on the `last_updated` field.

### Incremental Load for Weather Table (car_accident_dwh.weather)

#### Inserting New Weather Data:
Similar to the fact table, new weather records from the staging table are inserted into the data warehouse's weather table if they do not already exist.

The comparison is based on `date` and `region`.

#### Updating Existing Weather Data:
Existing records are updated if there are newer weather records in the staging table. Updates are made based on more recent `last_updated` timestamps.

### Incremental Load for Users Table (car_accident_dwh.users_dm)

#### Inserting New User Data:
New user data related to accidents is inserted into the `users_dm` dimension table from the staging database. Again, only records that do not exist in the data warehouse are inserted.

#### Updating Existing User Data:
The existing records are updated if the staging table contains more recent data.

### Full Load for Other Tables

The full load procedure is used to truncate and reload smaller dimension tables (like `places_category`, `places_lane`, etc.) from a source database. This ensures that these tables are fully refreshed each time.

#### The following steps are executed for each table:
- **Truncate Table**: Clear the existing data in the dimension table in the data warehouse.
- **Insert Data**: Load fresh data from the source database to repopulate the table.

### Scheduling of Procedures

#### Daily Incremental Loads:
The incremental load procedures are scheduled to run **daily** using MySQL events. This ensures that new and updated records in the staging tables are reflected in the data warehouse on a daily basis.

#### Weekly Full Loads:
The full load procedures for smaller dimension tables are scheduled to run **weekly** to keep these tables fully up to date.


<br><br>


<!-- How to run -->
<img src="./readme/title10.svg"/>

> To set up AcciTrack locally, follow these steps:

### How To Set Up Your Project

To set up this project locally, follow these steps:

#### Prerequisites
- **MySQL Server 8.0** installed and configured on your machine.
  
#### Installation

1. Download the folder from the [GitHub repository](https://github.com/Gebranassaad/SEF-Final-Project).

2. Download the original datasets from the Google Drive Folder [Original Datasets](https://drive.google.com/drive/folders/1lKoZoprvo3myAulJR2Z6ThpMKGuXlxpf?usp=sharing) and place all files into the following directory:

   ```sh
   C:\ProgramData\MySQL\MySQL Server 8.0\Uploads
   ```

3. Next, follow these steps:

  - Open the **ETL and DataWarehouse** folder. 
  - Run `Staging Database.sql` to create the staging database.
  - Run `Staging Load.sql` to load the data into the staging tables.
  - Run `DataWarehouse.sql` to create and populate the data warehouse.
  - Download the csv files from the Google Drive Folder [Tranformation Datasets](https://drive.google.com/drive/folders/1HiZvMa74lVKF5JHuzdXv-ylryFxVUQL6?usp=sharing) and put them in the **ETL and DataWarehouse** folder.



4. Finally, open the **notebook** named `transformation.ipynb` and update your MySQL credentials to link Python with MySQL. Once updated, run the code in the notebook.

5. To see the dashboard, Download the Power BI file [here](https://drive.google.com/file/d/1HxFbp7WHmekZxWYcjkSpOZm3CitE9A5u/view?usp=sharing).

Now, your environment should be ready for use.
