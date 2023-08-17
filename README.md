Trade Pal - Stock Price Analysis App
====================================

Trade Pal is a mobile application developed using the Flutter framework that allows users to analyze stock prices and make informed trading decisions. The app fetches real-time stock price data using the Alpha Vantage API and presents various metrics related to the stock's performance, including price changes, volume, 52-week range, PEG ratio, and analyst target price. Based on these metrics, the app provides a verdict on whether to buy, hold, wait, or sell the stock.

Features
--------

-   Real-time Stock Price Analysis: Fetches live stock price data from the Alpha Vantage API to provide accurate and up-to-date information.
-   Comprehensive Data Display: Displays essential stock metrics, including stock price, volume, change point, change percentage, 52-week range, PEG ratio, mean target price, and trading verdict.
-   Verdict Generation: Analyzes the collected data and generates a trading verdict (BUY, HOLD, WAIT, or SELL) based on predetermined conditions and stock performance indicators.
-   User-friendly Interface: Offers a simple and intuitive user interface with input fields for entering stock ticker symbols and a button to trigger the analysis.

Getting Started
---------------

To get started with Trade Pal, follow these steps:

1.  Clone the Repository: Clone this repository to your local machine.

2.  Install Dependencies: Open the project in your preferred IDE (e.g., Visual Studio Code) and ensure you have Flutter and Dart installed. Run the following command to install project dependencies:

    arduinoCopy code

    `flutter pub get`

3.  Alpha Vantage API Key: Obtain an API key from [Alpha Vantage](https://www.alphavantage.co/) to fetch stock price and overview data. Replace `'U3S5ZT27QDIJ3DUE'` with your actual API key in the `apiKey` variable within the `_fetchStockPrice` function in the `_MyHomePageState` class.

4.  Run the App: Connect your device/emulator and run the app using the following command:

    arduinoCopy code

    `flutter run`

Usage
-----

1.  Open the app on your device/emulator.

2.  Enter the stock ticker symbol in the provided text field.

3.  Click the "Analyze" button to fetch and analyze the stock data.

4.  The app will display the stock price, volume, change point, change percentage, 52-week range, PEG ratio, mean target price, and the trading verdict (BUY, HOLD, WAIT, or SELL) based on the calculated indicators.

Contributing
------------

Contributions to Trade Pal are welcome! If you find any bugs, want to add new features, or improve existing ones, feel free to submit pull requests.

License
-------

This project is licensed under the [MIT License](https://chat.openai.com/LICENSE).

Acknowledgments
---------------

-   The app utilizes the [Alpha Vantage API](https://www.alphavantage.co/) to fetch stock price and overview data.
- The information contained on this app and the resources available for download through this app is not intended as, and shall not be understood or construed as, financial advice. I am not an attorney, accountant or financial advisor, nor am I holding myself out to be, and the information contained on this Website is not a substitute for financial advice from a professional who is aware of the facts and circumstances of your individual situation. 