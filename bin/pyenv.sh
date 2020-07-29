echo -e "\n Installing virtual environment.. ⏳"
pyenv virtualenv 3.7.6 msc-project

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

pyenv local msc-project
echo -e "\n All done! 👍"