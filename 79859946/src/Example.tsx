import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"

export interface GPSFormValues {
  latitude: number,
  longitude: number,
maxDistance: number
}

const gpsSchema = z.object({
  latitude: z.coerce.number().min(-90).max(90),
  longitude: z.coerce.number().min(-180).max(180),
  maxDistance: z.coerce.number().min(1)
})

export function Example() {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<GPSFormValues>({
    resolver: zodResolver(gpsSchema)
  })

  const processForm = async (data: GPSFormValues) => {
    await fetch("/api/form", {
      method: "POST",
      body: JSON.stringify(data)
    })

    reset()
  }

  return (
    <form
      onSubmit={handleSubmit(processForm)}
      style={{ display: "flex", flexDirection: "column", width: 300 }}
    >
      <input
        {...register("latitude", { required: true })}
        name="latitude"
        type="text"
      />
      {errors.latitude?.message && <span>{errors.latitude?.message}</span>}

      <input
        {...register("longitude", { required: true })}
        name="longitude"
        type="text"
      />
      {errors.longitude?.message && <span>{errors.longitude?.message}</span>}

      <input
        {...register("maxDistance", { required: true })}
        name="maxDistance"
        type="text"
      />
      {errors.maxDistance?.message && (
        <span>{errors.maxDistance?.message}</span>
      )}
      <button>Submit</button>
    </form>
  )
}
