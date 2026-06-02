import { Router } from 'express';

import { authMiddleware } from '../middlewares/authMiddleware';

import { AppointmentController }
from '../controllers/AppointmentController';

const router = Router();

router.get(
  '/',
  authMiddleware,
  AppointmentController.getAll
);

router.post(
  '/',
  authMiddleware,
  AppointmentController.create
);

router.delete(
  '/:id',
  authMiddleware,
  AppointmentController.delete
);

router.put(
  '/:id',
  authMiddleware,
  AppointmentController.update
);

export default router;