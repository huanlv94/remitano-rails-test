import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = props => (
  <div className='share-container'>
    <div className='share-content'>
      <h3>Share a movie:</h3>
      <div className="mb-3">
        <input type="email" className="form-control" placeholder="Youtube URL" />
      </div>
    </div>
    <div className='share-bottom'>
      <button className='btn btn-primary full-width'>Share</button>
    </div>
  </div>
)

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('sharing_data')
  const data = JSON.parse(node.getAttribute('data'))
  ReactDOM.render(
    <Hello data={data}/>,
    document.getElementById('movie')
  )
})
