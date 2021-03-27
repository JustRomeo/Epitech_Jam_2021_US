FROM python:latest

RUN pip install --upgrade pip

COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 3000

CMD [ "python", "-u", "main.py" ]
