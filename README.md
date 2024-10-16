# Natural Language Q/A System for Retail Sales
This project is an end-to-end implementation of a Natural Language Q&A system that allows store managers to interact with retail sales data using natural language queries. The system leverages the power of Google PaLM, LangChain, and MySQL to convert user questions into SQL queries, execute them, and return meaningful results.

Natural language Queries like:

Q1. How many white color Adidas t shirts do we have left in the stock?

Q2.How much sales our store will generate if we can sell all extra-small size t shirts after applying discounts? The system is intelligent enough to generate accurate queries for given question and execute them on MySQL database



## Project Highlights

I build an LLM based question and answer system that will use following,
1.Google Palm LLM

2.Hugging face embeddings

3.Streamlit for UI

4.Langchain framework

5.Chromadb as a vector store

6.Few shot learning

In the UI, you can ask questions in a natural language and it will produce the answers


# Sample Questions
How many total t shirts are left in total in stock?

How many t-shirts do we have left for Nike in XS size and white color?

How much is the total price of the inventory for all S-size t-shirts?

How much sales amount will be generated if we sell all small size adidas shirts today after discounts?

# Project Structure
main.py: The main Streamlit application script.

langchain_helper.py: This has all the langchain code

requirements.txt: A list of required Python packages for the project.
