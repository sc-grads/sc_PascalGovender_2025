import streamlit as st
from PyPDF2 import PdfReader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

# OpenRouter API key (replace with your actual key)
OPENROUTER_API_KEY = "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"

# Streamlit UI
st.header("My First Chatbot")

with st.sidebar:
    st.title("Your Documents")
    file = st.file_uploader("Upload a PDF file and start asking questions", type="pdf")

# Process PDF
if file is not None:
    try:
        pdf_reader = PdfReader(file)
        text = ""
        for page in pdf_reader.pages:
            page_text = page.extract_text()
            if page_text:
                text += page_text

        # Chunking
        text_splitter = RecursiveCharacterTextSplitter(
            separators=["\n"],
            chunk_size=1000,
            chunk_overlap=150
        )
        chunks = text_splitter.split_text(text)

        st.write("Text chunks extracted from PDF:")
        st.write(chunks)

        # Embeddings using HuggingFace
        embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")

        # Vector store
        vector_store = FAISS.from_texts(chunks, embedding=embeddings)

        # User question
        user_question = st.text_input("Type your question here")

        if user_question:
            # Similarity search
            matched_docs = vector_store.similarity_search(user_question)

            # Define the LLM from OpenRouter
            llm = ChatOpenAI(
                openai_api_key=OPENROUTER_API_KEY,
                base_url="https://openrouter.ai/api/v1",
                model="google/gemma-3n-e2b-it:free"  # Free-tier OpenRouter model
            )

            # Define prompt template for retrieval-augmented generation (RAG)
            prompt_template = ChatPromptTemplate.from_template(
                """
                You are a helpful assistant. Use the following context to answer the user's question.
                Context: {context}
                Question: {question}
                Answer concisely and accurately.
                """
            )

            # Create retriever from vector store
            retriever = vector_store.as_retriever()

            # Build RAG chain
            rag_chain = (
                {"context": retriever, "question": RunnablePassthrough()}
                | prompt_template
                | llm
                | StrOutputParser()
            )

            # Invoke the chain
            response = rag_chain.invoke(user_question)
            st.write("Answer:")
            st.write(response)

    except Exception as e:
        st.error(f"An error occurred: {str(e)}")
else:
    st.info("Please upload a PDF file to proceed.")