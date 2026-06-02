import { Request, Response } from 'express';
import pool from '../config/db';

export class AppointmentController {

  static async getAll(req: any, res: Response) {

    try {

      const user = req.user;

      const result = await pool.query(
  'SELECT * FROM appointments ORDER BY id DESC'
);

      res.json(result.rows);

    } catch (error) {

      console.log(error);

      res.status(500).json({
        error: 'Erro ao buscar agendamentos'
      });

    }
  }

  static async create(req: any, res: Response) {

    try {

      const user = req.user;

      const {
        professional_id,
        customer_id,
        service_id,
        start_at,
        end_at,
        price,
        status,
        customer_name,
        customer_phone,
        notes
      } = req.body;

      const result = await pool.query(
        `
        INSERT INTO appointments (
          professional_id,
          customer_id,
          service_id,
          start_at,
          end_at,
          price,
          status,
          customer_name,
          customer_phone,
          notes,
          company_id
        )
        VALUES (
          $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11
        )
        RETURNING *
        `,
        [
          professional_id,
          customer_id,
          service_id,
          start_at,
          end_at,
          price,
          status,
          customer_name,
          customer_phone,
          notes,
          user.company_id
        ]
      );

      res.status(201).json(result.rows[0]);

    } catch (error) {

      console.log(error);

      res.status(500).json({
        error: 'Erro ao criar agendamento'
      });

    }
  }

    static async delete(
  req: Request,
  res: Response
) {

  try {

    const { id } = req.params;

    await pool.query(

      'DELETE FROM appointments WHERE id = $1',

      [id]
    );

    res.json({
      success: true,
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      error:
          'Erro ao deletar',
    });
  }
}

static async update(
  req: Request,
  res: Response
) {

  try {

    const { id } =
        req.params;

    const {

      customer_name,

      customer_phone,

      price,

    } = req.body;

    await pool.query(

      `UPDATE appointments
       SET

       customer_name = $1,

       customer_phone = $2,

       price = $3

       WHERE id = $4`,

      [

        customer_name,

        customer_phone,

        price,

        id,
      ],
    );

    res.json({
      success: true,
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      error:
          'Erro ao atualizar',
    });
  }
}

}
