#!/bin/bash
# setup.sh - Quick setup script for College Sports Prediction Engine

echo "============================================"
echo "College Sports Prediction Engine Setup"
echo "============================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.7+ first."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
pip install -r requirements.txt

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo "✓ Dependencies installed successfully"
echo ""

# Check for API key
if [ -z "$SRATING_API_KEY" ]; then
    echo "⚠️  SRATING_API_KEY environment variable not set"
    echo ""
    echo "To set it, run:"
    echo "  export SRATING_API_KEY='your-api-key-here'"
    echo ""
    echo "Or create a .env file with:"
    echo "  SRATING_API_KEY=your-api-key-here"
    echo ""
    echo "Note: You can still train models with mock data for testing"
    echo ""
else
    echo "✓ API key found"
    echo ""
fi

# Ask if user wants to train models now
echo "============================================"
echo "Would you like to train the models now?"
echo "This will use mock data if API key is not set."
echo "============================================"
echo ""
read -p "Train models? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🚀 Starting model training..."
    python3 train_model.py
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✓ Models trained successfully!"
        echo ""
        echo "To run the application:"
        echo "  streamlit run main.py"
        echo ""
    else
        echo "❌ Model training failed"
        exit 1
    fi
else
    echo ""
    echo "Skipping model training."
    echo ""
    echo "To train models later, run:"
    echo "  python3 train_model.py"
    echo ""
    echo "To run the application:"
    echo "  streamlit run main.py"
    echo ""
fi

echo "============================================"
echo "Setup complete! 🎉"
echo "============================================"
