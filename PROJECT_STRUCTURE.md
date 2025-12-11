# 📁 Project Structure & File Guide

## Directory Layout

```
college-sports-prediction/
│
├── 📄 requirements.txt              # Python dependencies
├── 📄 README.md                     # Complete documentation
├── 📄 QUICKSTART.md                 # Quick start guide
├── 📄 PROJECT_STRUCTURE.md          # This file
├── 📄 setup.sh                      # Automated setup script
├── 📄 .env.example                  # Environment variable template
│
├── 🐍 utils.py                      # Core utilities (1,000+ lines)
├── 🐍 train_model.py                # Model training (800+ lines)
├── 🐍 main.py                       # Streamlit app (600+ lines)
│
└── 📂 model/                        # Trained models directory
    ├── college_basketball_xgb.pkl
    ├── college_football_xgb.pkl
    ├── college_basketball_feature_importance.csv
    └── college_football_feature_importance.csv
```

---

## 📄 File Descriptions

### Core Application Files

#### `utils.py` - Data Handling & Feature Engineering
**Purpose**: Core utility functions for data processing

**Key Functions**:
- `fetch_data_from_srating()` - API interaction with error handling
- `calculate_elo()` - Dynamic ELO rating system (800+ lines of implementation)
- `create_features()` - Master feature engineering pipeline
- `calculate_rolling_stats()` - Rolling average calculations
- `calculate_rest_days()` - Team fatigue metrics
- `prepare_prediction_features()` - Single game feature prep

**Dependencies**: pandas, numpy, requests

**When to Edit**:
- Adding new features
- Modifying ELO parameters
- Changing rolling window sizes
- Adding new data sources

---

#### `train_model.py` - Model Training Pipeline
**Purpose**: Orchestrates the complete model training workflow

**Key Functions**:
- `prepare_training_data()` - Complete data prep pipeline
- `fetch_historical_games()` - API data fetching for date ranges
- `clean_game_data()` - Data standardization and cleaning
- `train_and_save_model()` - XGBoost training and persistence
- `generate_mock_data()` - Synthetic data for testing

**Dependencies**: scikit-learn, xgboost, joblib, pandas, numpy

**When to Edit**:
- Changing model architecture
- Tuning hyperparameters
- Adjusting training/test split
- Modifying cross-validation

**Usage**:
```bash
python train_model.py
```

---

#### `main.py` - Streamlit Web Application
**Purpose**: Interactive UI for generating and viewing predictions

**Key Functions**:
- `load_model()` - Cached model loading (@st.cache_resource)
- `fetch_todays_games()` - Get games for prediction date
- `generate_predictions()` - Apply model to generate probabilities
- `display_predictions_table()` - Formatted prediction display
- `display_high_confidence_picks()` - Highlight best bets
- `display_statistics()` - Summary metrics

**Dependencies**: streamlit, pandas, numpy, joblib

**When to Edit**:
- Changing UI layout
- Adding new visualizations
- Modifying prediction display
- Adding filters or controls

**Usage**:
```bash
streamlit run main.py
```

---

### Configuration Files

#### `requirements.txt` - Python Dependencies
**Contents**:
```
pandas>=2.0.0          # Data manipulation
numpy>=1.24.0          # Numerical computing
requests>=2.31.0       # API calls
scikit-learn>=1.3.0    # ML utilities
xgboost>=2.0.0         # Gradient boosting
joblib>=1.3.0          # Model persistence
streamlit>=1.29.0      # Web UI
python-dotenv>=1.0.0   # Environment variables
```

**When to Update**:
- Adding new Python libraries
- Upgrading package versions
- Resolving dependency conflicts

---

#### `.env.example` - Environment Template
**Purpose**: Template for required environment variables

**Contents**:
```bash
SRATING_API_KEY=your-api-key-here
```

**Setup**:
```bash
cp .env.example .env
# Edit .env with your actual API key
```

---

### Documentation Files

#### `README.md` - Complete Documentation
**Sections**:
- Features overview
- Installation guide
- Usage instructions
- Model explanation
- API documentation
- Troubleshooting
- Advanced configuration

**Length**: 500+ lines

---

#### `QUICKSTART.md` - Quick Start Guide
**Purpose**: Get running in <5 minutes

**Sections**:
- 3-step setup
- Basic usage
- Understanding output
- Common issues
- Tips and tricks

**Length**: 200+ lines

---

#### `setup.sh` - Automated Setup Script
**Purpose**: One-command setup

**What it does**:
1. Checks Python installation
2. Installs dependencies
3. Verifies API key (optional)
4. Offers to train models
5. Provides next steps

**Usage**:
```bash
bash setup.sh
```

---

## 📂 Model Directory

### Generated Files

#### `college_basketball_xgb.pkl`
- Trained XGBoost model for CBB
- Size: ~400-500 KB
- Binary format (pickle)
- Contains 200 decision trees

#### `college_football_xgb.pkl`
- Trained XGBoost model for CFB
- Size: ~400-500 KB
- Binary format (pickle)
- Contains 200 decision trees

#### `*_feature_importance.csv`
- Feature rankings by importance
- Format: feature name, importance score
- Used for model interpretation
- Helps identify key predictors

---

## 🔄 Workflow Diagram

```
┌─────────────────────────────────────────────────────┐
│                   Data Pipeline                      │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│  1. fetch_data_from_srating()                       │
│     └─ API call with authentication                 │
│     └─ Error handling & validation                  │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│  2. calculate_elo()                                 │
│     └─ Sort games chronologically                   │
│     └─ Update ratings after each game               │
│     └─ Store pre-game ELO values                    │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│  3. create_features()                               │
│     └─ Calculate rolling statistics                 │
│     └─ Compute rest days                            │
│     └─ Add momentum indicators                      │
│     └─ Engineer domain features                     │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│  4. train_and_save_model()                          │
│     └─ Split train/test data                        │
│     └─ Train XGBoost classifier                     │
│     └─ Evaluate performance                         │
│     └─ Save model to disk                           │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│  5. Streamlit Application                           │
│     └─ Load trained model                           │
│     └─ Fetch today's games                          │
│     └─ Generate predictions                         │
│     └─ Display results                              │
└─────────────────────────────────────────────────────┘
```

---

## 🎯 Feature Engineering Pipeline

```
Raw Game Data
      │
      ▼
┌─────────────────┐
│  Clean Data     │
│  - Dates        │
│  - Scores       │
│  - Teams        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  ELO Ratings    │
│  - Home ELO     │
│  - Away ELO     │
│  - Differential │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Rolling Stats  │
│  - 3 games      │
│  - 5 games      │
│  - 10 games     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Context        │
│  - Rest days    │
│  - Momentum     │
│  - Streaks      │
└────────┬────────┘
         │
         ▼
    Feature Matrix
    (19 features)
```

---

## 📊 Data Flow

### Training Phase
```
Historical Games (API/Mock)
    → Clean & Standardize
    → Calculate ELO
    → Engineer Features
    → Split Train/Test
    → Train XGBoost
    → Evaluate & Save
```

### Prediction Phase
```
Today's Games (API/Mock)
    → Load Trained Model
    → Prepare Features
    → Generate Probabilities
    → Calculate Confidence
    → Display Results
```

---

## 🔧 Customization Points

### Easy Customizations
1. **ELO K-Factor**: Line 106 in utils.py
2. **Rolling Windows**: Line 157 in utils.py
3. **Model Parameters**: Line 235 in train_model.py
4. **UI Layout**: Lines 380-450 in main.py

### Medium Customizations
1. **Add New Features**: Modify `create_features()` in utils.py
2. **Change Model Type**: Replace XGBoost in train_model.py
3. **Add Data Sources**: Extend API calls in utils.py

### Advanced Customizations
1. **Multi-Model Ensemble**: Combine multiple algorithms
2. **Real-Time Updates**: Add live score tracking
3. **Player Statistics**: Individual player features
4. **Betting Integration**: Add odds and line data

---

## 🧪 Testing Strategy

### Unit Tests (Future Enhancement)
```python
# test_utils.py
def test_calculate_elo():
    # Test ELO calculation
    pass

def test_create_features():
    # Test feature engineering
    pass
```

### Integration Tests
```python
# test_pipeline.py
def test_full_pipeline():
    # Test end-to-end workflow
    pass
```

### Manual Testing
1. Run with mock data
2. Verify predictions are reasonable
3. Check feature importance makes sense
4. Test UI responsiveness

---

## 📈 Performance Optimization

### Current Optimizations
- `@st.cache_resource` for model loading
- `@lru_cache` for repeated calculations
- Vectorized operations with numpy/pandas

### Future Optimizations
- Database caching for historical data
- Parallel model training
- GPU acceleration for XGBoost
- API request batching

---

## 🔐 Security Considerations

### Current Implementation
- API key via environment variable
- No hardcoded credentials
- Input validation on API responses

### Production Recommendations
- Use secrets management service
- Add rate limiting
- Implement API key rotation
- Add user authentication
- Enable HTTPS only

---

## 📝 Version Control

### Recommended .gitignore
```
# Environment
.env
__pycache__/
*.pyc

# Models
model/*.pkl

# Data
data/
*.csv

# IDE
.vscode/
.idea/
```

---

## 🚀 Deployment Options

### Local
```bash
streamlit run main.py
```

### Streamlit Cloud
1. Push to GitHub
2. Connect to Streamlit Cloud
3. Add secrets (API key)
4. Deploy!

### Docker
```dockerfile
FROM python:3.9
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD streamlit run main.py
```

### Heroku / AWS / GCP
- Include Procfile
- Set environment variables
- Configure port binding

---

**Need Help?** Check README.md for detailed documentation!
