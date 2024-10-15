import pandas as pd
import dash
# Add clientside_callback to imports
from dash import dcc, html, clientside_callback
from dash.dependencies import Input, Output
from dash_echarts import DashECharts
import dash_table
import datetime

app = dash.Dash(__name__)

# Load the data into Python
missiles_daily = pd.read_csv('missiles_daily.csv', parse_dates=['Date'])
dat_expanded_preprocessed = pd.read_csv(
    'dat_expanded_preprocessed.csv', parse_dates=['Date'])

missiles_daily['Date'] = pd.to_datetime(missiles_daily['Date'])
dat_expanded_preprocessed['Date'] = pd.to_datetime(
    dat_expanded_preprocessed['Date'])

# Create date marks for the slider


def create_date_marks(dates, num_marks=4):
    min_date = dates.min()
    max_date = dates.max()
    date_range = pd.date_range(start=min_date, end=max_date, periods=num_marks)
    date_marks = {
        int(pd.Timestamp(date).timestamp() * 1000): date.strftime('%Y-%m-%d')
        for date in date_range
    }
    return date_marks


date_marks = create_date_marks(missiles_daily['Date'], num_marks=4)

app.layout = html.Div([
    # Store the data in the frontend using dcc.Store
    dcc.Store(id='missiles-daily-store',
              data=missiles_daily.to_dict('records')),
    dcc.Store(id='dat-expanded-store',
              data=dat_expanded_preprocessed.to_dict('records')),

    html.Div([
        DashECharts(
            option={},
            id='missile-plot',
            style={'width': '100%', 'height': '500px'}
        ),
    ], style={'border': '1px solid #ccc', 'padding': '10px', 'marginBottom': '20px'}),

    html.Div([
        dcc.RangeSlider(
            id='date-range-slider',
            min=int(missiles_daily['Date'].min().timestamp() * 1000),
            max=int(missiles_daily['Date'].max().timestamp() * 1000),
            value=[
                int(missiles_daily['Date'].min().timestamp() * 1000),
                int(missiles_daily['Date'].max().timestamp() * 1000)
            ],
            marks=date_marks,
            step=None
        )
    ], style={'marginBottom': '20px'}),

    # Add the table here
    html.Div(id='table-container', style={'display': 'none'}),
])

# Clientside callback for updating the graph
clientside_callback(
    """
    function(date_range, missiles_daily) {
        const startDate = new Date(date_range[0]);
        const endDate = new Date(date_range[1]);

        // Check if data exists
        if (!missiles_daily || missiles_daily.length === 0) {
            return {};  // Return empty chart options if no data
        }

        const filteredData = missiles_daily.filter(row => {
            const date = new Date(row['Date']);
            return date >= startDate && date <= endDate;
        });

        const option = {
            title: {
                text: 'Daily Tally of Russian Missile Attacks',
                left: 'center',
                textStyle: { fontFamily: 'Optima, sans-serif' }
            },
            tooltip: { trigger: 'axis' },
            legend: { data: ['Launched', 'Destroyed'], bottom: 0 },
            xAxis: { type: 'time', name: 'Date' },
            yAxis: { type: 'value', name: 'Count' },
            series: [
                {
                    name: 'Launched',
                    type: 'bar',
                    data: filteredData.map(row => [new Date(row['Date']).getTime(), row['total_launched']])
                },
                {
                    name: 'Destroyed',
                    type: 'bar',
                    data: filteredData.map(row => [new Date(row['Date']).getTime(), row['total_destroyed']])
                }
            ]
        };

        return option;
    }
    """,
    Output('missile-plot', 'option'),
    Input('date-range-slider', 'value'),
    Input('missiles-daily-store', 'data')
)

# New Python callback for the table


@app.callback(
    [Output('table-container', 'children'),
     Output('table-container', 'style')],
    [Input('date-range-slider', 'value'), Input('dat-expanded-store', 'data')]
)
def update_table(date_range, dat_expanded_preprocessed):
    start_date = pd.to_datetime(date_range[0], unit='ms')
    end_date = pd.to_datetime(date_range[1], unit='ms')

    # Filter the data
    filtered_data = [row for row in dat_expanded_preprocessed if start_date <=
                     pd.to_datetime(row['Date']) <= end_date]

    # If no data, hide the table
    if len(filtered_data) == 0:
        return html.Div("No data available for the selected date range."), {'display': 'none'}

    # If data is available, show the table
    columns = [{'name': i, 'id': i} for i in filtered_data[0].keys()]
    table = dash_table.DataTable(
        data=filtered_data,
        columns=columns,
        page_size=10,
        style_table={'overflowX': 'auto'},
        style_cell={'textAlign': 'left', 'padding': '5px',
                    'fontFamily': 'Optima, sans-serif'},
        style_header={'backgroundColor': '#4c3d75',
                      'fontWeight': 'bold', 'color': 'white'}
    )

    return table, {'display': 'block'}


if __name__ == '__main__':
    app.run_server(debug=True)
