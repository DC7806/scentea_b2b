import 'core-js/stable'
import 'regenerator-runtime/runtime'
require('@rails/ujs').start()

import { Application } from 'stimulus'
// import { definitionsFromContext } from 'stimulus/webpack-helpers'
import NotificationController from '../controllers/shared/notification_controller'

const stimulus = Application.start()
stimulus.register('notification', NotificationController)
// const controllers = require.context('../controllers/backend/', true, /.js$/)
// stimulus.load(definitionsFromContext(controllers))

import 'jquery'
import '../src/backend/javascripts/'

import '../src/backend/stylesheets/index.scss'
