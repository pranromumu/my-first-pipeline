@echo off
echo ====== Building my-first-pipeline ======
echo [1/4] Installing package in editable mode...
pip install -e .
echo [2/4] Installing test dependencies...
pip install -r requirements.txt
echo [2.5/4] Running linter and formatter...
flake8 src/ tests/
black --check src/ tests/
if errorlevel 1 exit /b 1
echo [2.5/4] Running dependency security scan...
safety check --full-report
if errorlevel 1 exit /b 1
echo [2.5/4] Running dependency security scan...
pip-audit --requirement requirements.txt
if errorlevel 1 exit /b 1
echo [3/4] Running tests with coverage...
pytest tests/ -v --cov=src --cov-report=term-missing --cov-fail-under=80
if errorlevel 1 exit /b 1
echo [4/4] Build SUCCESS!
pause