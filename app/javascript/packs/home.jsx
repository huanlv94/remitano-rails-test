import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import _ from 'lodash'

const Hello = props => (
  <div className='share-container'>
    {_.times(10, (i) => (
      <div className='share-content'>
        <div className='share-preview embed-responsive'>
          <iframe width = '39%' className="embed-responsive-item" src="https://www.youtube.com/embed/kGT73GcwhCU?rel=0" allowFullScreen></iframe>
          <div className='share-description' width='60%'>
            <h5>Video title</h5>
            <p className='no-margin'>Share by: huan@gmail.com</p>
            <p className='no-margin'>
              <span className="bi bi-hand-thumbs-up"></span>
              <span>69</span>
              <span className="bi bi-hand-thumbs-down"></span>
              <span>1</span>
             </p>
            <p className='no-margin'> Description:</p>
            <p>as cj allowfullscreen
            asc jasc ajscha
            ascn asjcashjcbasc
            jascjascbhascb
            </p>
          </div>
        </div>
      </div>
    ))}
    <div className='share-loadmore'>
      <button className='btn btn-primary full-width'>Load more</button>
    </div>
  </div>
)

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('sharing_data')
  const data = JSON.parse(node.getAttribute('data'))
  ReactDOM.render(
    <Hello data={data}/>,
    document.getElementById('home')
  )
})
