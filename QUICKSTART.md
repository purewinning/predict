# 🚀 Quick Start Guide

## Get Started in 3 Steps

### Step 1: Set Up Environment

```bash
# Run the setup script
bash setup.sh

# OR manually install
pip install -r requirements.txt
```

### Step 2: Configure API Key (Optional)

```bash
# Copy the example file
cp .env.example .env

# Edit .env and add your API key
# SRATING_API_KEY=your-actual-key-here

# OR export directly
export SRATING_API_KEY="your-api-key-here"
```

**Note**: You can skip this and use mock data for testing!

### Step 3: Train Models

```bash
# Train both CBB and CFB models
python train_model.py
```

This will:
- ✓ Generate training data (mock or real)
- ✓ Calculate ELO ratings
- ✓ Engineer features
- ✓ Train XGBoost models
- ✓ Save models to `model/` directory
- ✓ Display performance metrics

Expected output:
```
Training data prepared:
  Total games: 1000
  Features: 19
  Home win rate: 0.567

Model Performance
  Accuracy: 0.7450
  ROC AUC: 0.8245
```

### Step 4: Run the Application

```bash
streamlit run main.py
```

Your browser will open to `http://localhost:8501`

## 🎯 Using the App

1. **Select Sport**: Choose CBB or CFB from sidebar
2. **Pick Date**: Select the date you want predictions for
3. **Fetch Games**: Click the button to load games
4. **View Predictions**: See win probabilities and picks!

## 📊 Understanding the Output

### Win Probability
- **50-60%**: Toss-up game
- **60-70%**: Moderate favorite
- **70-80%**: Strong favorite
- **80%+**: Heavy favorite

### Confidence Level
- **High**: Model is very confident (≥65%)
- **Medium**: Moderate confidence (30-65%)
- **Low**: Close game (<30%)

### High-Confidence Picks
These are the model's strongest predictions, automatically highlighted for you.

## 🔧 Customization

### Change Model Parameters

Edit `train_model.py`:

```python
model = XGBClassifier(
    n_estimators=200,    # More trees = better fit
    max_depth=6,         # Deeper = more complex
    learning_rate=0.1,   # Lower = slower learning
)
```

### Adjust ELO System

Edit `utils.py`:

```python
# More sensitive to recent games
calculate_elo(df, K=30)

# Different starting rating
calculate_elo(df, initial_elo=1600)
```

### Modify Features

Edit `create_features()` in `utils.py` to add your own features!

## 🐛 Troubleshooting

### "Model not found" error
**Solution**: Run `python train_model.py` first

### "API key not set" warning
**Solution**: It's okay! The system will use mock data. For real data, set the API key.

### Low accuracy
**Try**:
- Train with more historical data
- Adjust K-factor in ELO calculation
- Modify XGBoost parameters
- Add more features

### No games showing
**Check**:
- Selected date has games scheduled
- Using correct sport/organization/division
- API connection (if using real data)

## 📚 Next Steps

1. **Explore the Code**: Read the docstrings in each module
2. **Test Features**: Try different feature combinations
3. **Tune Models**: Experiment with hyperparameters
4. **Add Sports**: Extend to NBA, NFL, etc.
5. **Track Performance**: Compare predictions vs actual results

## 💡 Tips for Best Results

1. **More Data = Better**: Train on 2+ seasons of historical data
2. **Regular Updates**: Retrain models periodically
3. **Feature Engineering**: The most important step!
4. **Domain Knowledge**: Incorporate sports insights
5. **Ensemble Models**: Combine multiple models for better predictions

## 🎓 Learn More

- **ELO Ratings**: Read about chess rating systems
- **XGBoost**: Study gradient boosting algorithms
- **Feature Engineering**: Learn ML feature selection
- **Sports Analytics**: Explore sabermetrics and analytics

## ⚠️ Remember

This is for **educational purposes only**:
- Sports are unpredictable
- Past performance ≠ future results
- Use responsibly
- Have fun! 🎉

---

**Questions?** Check the full README.md for detailed documentation.
