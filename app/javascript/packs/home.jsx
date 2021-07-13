import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = props => (
  <div>Hello {props.data.message}!</div>
)

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('sharing_data')
  const data = JSON.parse(node.getAttribute('data'))
  ReactDOM.render(
    <Hello data={data}/>,
    document.body.appendChild(document.createElement('div')),
  )
})
