# SQL Query

This folder contains the complex SQL query used in our experiment to evaluate the explanation capabilities of various 7B parameter Large Language Models (LLMs).

## Query Generation

The SQL query used in this experiment was generated using ChatGPT-3.5. We prompted ChatGPT to create a complex query that incorporates several advanced SQL features, including:

- Multiple Common Table Expressions (CTEs)
- Various JOIN operations
- Window functions
- Conditional logic (CASE statements)
- Aggregations
- Filtering and sorting

The goal was to create a query that would challenge the LLMs' ability to explain intricate database operations and provide insights into their comprehension of complex SQL structures.

## Query Purpose

The generated query aims to perform a comprehensive analysis of a hypothetical e-commerce database, covering aspects such as:

1. Customer segmentation
2. Product performance analysis
3. Inventory management
4. Promotion effectiveness evaluation

This multi-faceted query allows us to assess how well each LLM can explain different SQL concepts and their business implications.

## File Contents

- `complex_query.sql`: The full SQL query used in the experiment

## Note to Readers

While this query was generated by AI, it represents a realistic complex query that one might encounter in a business analytics scenario. The LLMs in our experiment were tasked with explaining this query as if it were a real-world database operation.

For the full context of how this query was used and the results of our experiment, please refer to the main README file in the repository root.