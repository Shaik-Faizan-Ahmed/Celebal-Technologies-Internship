# Celebal Technologies Summer Internship 2026

## Week 4 Assignment – Azure Cloud Fundamentals and Azure Data Factory

### Student Details

**Name:** Shaik Faizan Ahmed
**Roll Number:** 23B81A05L3
**College:** CVR College of Engineering

---

## Assignment Overview

This repository contains the complete implementation and documentation for **Week 4** of the Celebal Technologies Summer Internship Program.

The assignment focuses on learning and implementing Azure cloud services, including:

* Azure Resource Groups
* Azure Storage Accounts
* Azure Blob Storage
* Azure Data Factory (ADF)
* Linked Services
* Datasets
* Get Metadata Activity
* Copy Data Activity
* ForEach Activity
* Azure IAM Roles and Permissions

---

## Repository Contents

### 1. Week 4 Report

Contains the detailed report for all assignment tasks including:

* Task 1: Azure Portal Exploration and Resource Group Creation
* Task 2: Storage Setup
* Task 3: Azure Data Factory Basics
* Task 4: Pipeline Development
* Task 5: Pipeline Execution
* Task 6: IAM Roles and Access Management
* Mini Project Report

The report includes:

* Objective
* Step-by-step implementation
* Outputs
* Screenshots
* Learning outcomes

---

### 2. Dataset Files

The following CSV files were used during the assignment:

* Sample-Superstore.csv(given in celebal assignment portal)
* retail_sales.csv(created by me and used during task6-ForEach activity)
* employee_data.csv(created by me and used during task6-ForEach activity)
* customer_orders.csv(created by me and used during task6-ForEach activity)

These files were uploaded to Azure Blob Storage and used for data pipeline implementation.

---


## Mini Project

### Problem Statement

Build a complete pipeline that reads a CSV file from Azure Blob Storage and processes it using Azure Data Factory.

### Components Used

* Azure Resource Group
* Azure Storage Account
* Blob Storage Containers
* Azure Data Factory
* Linked Service
* Source Dataset
* Destination Dataset
* Get Metadata Activity
* Copy Data Activity

### Expected Output

* Successful pipeline execution
* Metadata validation
* File copied successfully to destination container

---

## Learning Outcomes

Through this assignment, I learned:

* How Azure resources are organized using Resource Groups.
* How Azure Blob Storage stores and manages files.
* How Azure Data Factory connects to storage systems.
* How datasets and linked services are configured.
* How metadata can be retrieved before processing data.
* How to build scalable pipelines using ForEach activities.
* How IAM roles and permissions control access to Azure resources.
* How to implement end-to-end data movement pipelines in Azure.

---

## Note

During Task 6 (IAM Configuration), the assignment required assigning the Contributor role. However, under the Azure for Students subscription, the Contributor role was not available for assignment in the current access configuration. This issue was discussed during the mentor meeting, and we were advised to proceed using the available roles (Owner, Reader, and Storage Blob Data Contributor).
