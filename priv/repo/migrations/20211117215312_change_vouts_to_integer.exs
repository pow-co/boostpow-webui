defmodule Proofofwork.Repo.Migrations.ChangeVoutsToInteger do
  use Ecto.Migration


  def up do
     execute """
       alter table boost_job_proofs alter column job_vout type integer using (job_vout::integer);
      """

     execute """
       alter table boost_job_proofs alter column spend_vout type integer using (spend_vout::integer);
      """
  end

  def down do
     execute """
       alter table boost_job_proofs alter column job_vout type character varying(255);
      """
     execute """
       alter table boost_job_proofs alter column spend_vout type character varying(255);
      """
  end

end
