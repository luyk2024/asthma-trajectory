# Impact of Early-Life Antibiotic Exposure on Childhood Asthma Trajectories
Yankun Lu, Yichao Wang, Jing Wang, Yanhong J. Hu(Corresponding author)

## Overview  
This project examines the association between early-life antibiotic exposure and childhood asthma development. Using data from the **Australian Longitudinal Study of Australian Children (LSAC)** and **Pharmaceutical Benefits Scheme**, we investigate how antibiotic use in the first two years of life influences asthma trajectories from ages 6 to 15.

## Methods  
- **Dataset:** LSAC with linked Pharmaceutical Benefits Scheme data  
- **Participants:** 5,107 children, with 4,318 included in final analysis (84.6% retention)  
- **Exposure:** Antibiotic use from **0–24 months**  
- **Outcome:** Asthma phenotypes derived using **group-based trajectory modeling**  

## Key Findings  
We identified four asthma phenotypes:  
- 🟢 **Always-low-risk (79.0%)**  
- 🔵 **Early-resolving asthma (7.1%)**  
- 🔴 **Early-persistent asthma (7.9%)**  
- 🟠 **Late-onset asthma (6.0%)**  

### Association with Antibiotic Exposure  
- **Any early-life antibiotic exposure** → **2.3× increased risk** of early-persistent asthma (*95% CI: 1.47–3.67; p < 0.001*)  
- **Subgroup Analysis:**  
  - 📌 **Second-generation cephalosporins** → **2.7× increased risk**  
  - 📌 **β-lactam (excluding cephalosporins/macrolides)** → **2× increased risk**  

## Conclusion  
Early-life antibiotic exposure is linked to a higher risk of early-persistent childhood asthma. These findings emphasize the need for careful antibiotic use in infants, particularly for **viral infections where antibiotics are unnecessary**.

## Repository Contents  
- 📂 **Data Processing:** Scripts for cleaning and preparing LSAC & Pharmaceutical Benefits Scheme data  
- 📊 **Analysis:** Code for trajectory modeling and statistical analysis  
- 📈 **Results:** Visualizations and summary tables  

## Usage  
To reproduce the analysis, clone this repository and follow the instructions in the `README.md` and associated scripts.

## How to Cite This Work
> Lu Y, Wang Y, Wang J, Lowe AJ, Grzeskowiak LE, Hu YJ. Early-Life Antibiotic Exposure and Childhood Asthma Trajectories: A National Population-Based Birth Cohort. Antibiotics [Internet]. 2023 Feb 3 [cited 2025 Feb 10];12(2):314–4. Available from: https://www.mdpi.com/2079-6382/12/2/314
‌
```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
