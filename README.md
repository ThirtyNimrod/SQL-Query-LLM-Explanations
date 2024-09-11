# SQL Query Explanations by 7B LLMs

This repository contains the raw data from an experiment comparing the performance of four 7B parameter Large Language Models (LLMs) in explaining a complex SQL query. The experiment aims to evaluate the capability of these models in providing clear, accurate, and insightful explanations of database operations.

## Repository Structure

- `SQL Query/`: Contains the original complex SQL query used in the experiment.
- `LLM Explanations/`: Contains the full, unedited outputs from each LLM.
  - `LLaVA.txt`
  - `llama_3_1.txt`
  - `Gemma2.txt`
  - `Mistral.txt`

## Experiment Overview

We tasked four leading 7B LLMs with explaining a complex SQL query involving multiple Common Table Expressions (CTEs), intricate joins, window functions, and conditional logic. The query was designed to analyze customer segments, product performance, inventory status, and promotion effectiveness.

Each model was evaluated on five key parameters:
1. Accuracy of Explanation
2. Comprehensiveness
3. Structure of the Response
4. Depth of Analysis
5. Performance Considerations

## Models Tested

1. LLaVA
2. llama 3.1
3. Gemma2
4. Mistral

## Key Findings

- All models demonstrated strong capabilities in explaining complex SQL queries.
- llama 3.1 achieved the highest overall score, excelling in comprehensiveness and depth of analysis.
- Mistral showed particular strength in discussing performance considerations.
- LLaVA provided the most well-structured explanations.
- Gemma2, while scoring slightly lower, showed consistent performance across all parameters.

For a detailed analysis of the results and their implications, please refer to the full article [insert link to your article when published].

## Usage

Feel free to explore the SQL query and LLM explanations. These materials can be valuable for:
- Researchers studying LLM capabilities in technical domains
- Educators teaching SQL or database concepts
- Data professionals interested in AI-assisted query understanding

## Contributing

While this repository primarily serves as a data archive for the experiment, we welcome discussions and insights. Feel free to open an issue if you have questions or observations about the data.
