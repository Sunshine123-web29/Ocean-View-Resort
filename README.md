# Ocean View Resort Management System 🏨

![Version](https://img.shields.io/badge/version-2.0.0-blue)
![Build](https://img.shields.io/badge/build-passing-brightgreen)
![Java](https://img.shields.io/badge/Java-JDK%2017%2B-orange)

A comprehensive Java-based desktop application designed to streamline hotel operations, guest management, and automated billing for Ocean View Resort.

---

## Project Overview
The Ocean View Resort Management System is a robust software solution developed to replace manual record-keeping. It features secure user authentication, real-time guest tracking, and professional PDF invoice generation. The system follows the **DAO (Data Access Object)** pattern to ensure clean separation between the UI and database logic.

### Key Features
* **Secure Authentication:** Role-based login system for administrators and staff.
* **Guest Management:** Full CRUD (Create, Read, Update, Delete) functionality for guest records.
* **Automated Billing:** Instant calculation of stay costs with automated PDF invoice generation.
* **Live Reporting:** Real-time occupancy lists and printable reports.
* **Data Integrity:** Backed by a MySQL database with strict schema constraints.

---

## Directory Hierarchy
The repository is organized according to professional Java/Eclipse standards:

* **/src** → Java source files organized into packages (`com.oceanview.util`, `com.oceanview.dao`, `com.oceanview.model`, `com.oceanview.controller`).
* **/lib** → External JAR libraries (MySQL Connector, JasperReports, JUnit).
* **/database** → SQL schema scripts, table structures, and sample data.
* **/tests** → JUnit test cases for unit and integration testing.
* **/assets** → UI screenshots, icons, and design mockups.
* **/docs** → Requirements, UML diagrams, and testing plans.

---

## Installation & Setup

### Prerequisites
* **Java Development Kit (JDK) 17** or higher.
* **MySQL Server** (Local or Cloud).
* **IDE:** Eclipse, NetBeans, or IntelliJ IDEA.

### Setup Steps
1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/Sunshine123-web29/Ocean-View-Resort-System.git](https://github.com/Sunshine123-web29/Ocean-View-Resort-System.git)
    ```
2.  **Database Configuration:**
    * Import the SQL script located in `/database/oceanview_db.sql` into your MySQL server.
    * Update the `DBConnection.java` file with your MySQL username and password.
3.  **Library Configuration:**
    * Add all JAR files from the `/lib` folder to your project's Build Path.
4.  **Run the Application:**
    * Execute the `LoginFrame.java` file from the `com.oceanview.ui` package.

---

## Testing (TDD)
This project utilizes **Test-Driven Development (TDD)**. Automated tests are implemented using **JUnit** to verify database connectivity and DAO logic.
* Run tests located in the `/tests` folder to verify system stability.
* Current Status: **All tests passed (v2.0.0)**.

---

## Version History
* **v1.0.0:** Initial project setup and core UI components.
* **v1.1.0:** Integrated MySQL DAO layer and CRUD logic.
* **v1.2.0:** Added JasperReports for automated PDF billing.
* **v2.0.0:** Final stable release with optimized UI and bug fixes.

---

## Developer
**Kanchana Sewwandee Chandrasekara** *Software Engineering Undergraduate | Cardiff Metropolitan University*

---

## 📄 License
This project is developed for academic purposes as part of the BSc (Hons) Software Engineering program.
