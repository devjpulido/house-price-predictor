# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Set PYTHONPATH to include /app
ENV PYTHONPATH=/app

# Install Python dependencies
COPY src/api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create directory structure for models
RUN mkdir -p /app/models/trained

# Copy model and preprocessor files
COPY models/trained/house_price_model.pkl /app/models/trained/
COPY models/trained/preprocessor.pkl /app/models/trained/

# Copy application code
COPY src/api/ /app/

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]