'use client'

import { useState, useEffect } from 'react'
import ImageUpload from './components/ImageUpload'
import ImageGallery from './components/ImageGallery'

interface Image {
  _id: string
  filename: string
  originalName: string
  path: string
  size: number
  uploadDate: string
  description: string
}

export default function Home() {
  const [images, setImages] = useState<Image[]>([])
  const [loading, setLoading] = useState(true)

  const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api'

  const fetchImages = async () => {
    try {
      const response = await fetch(`${API_URL}/images`)
      const data = await response.json()
      setImages(data)
    } catch (error) {
      console.error('Error fetching images:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleImageUpload = (newImage: Image) => {
    setImages(prev => [newImage, ...prev])
  }

  const handleImageDelete = (imageId: string) => {
    setImages(prev => prev.filter(img => img._id !== imageId))
  }

  useEffect(() => {
    fetchImages()
  }, [])

  return (
    <main className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-4xl font-bold text-center text-gray-800 mb-8">
          Image Upload App
        </h1>
        
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <div className="bg-white rounded-lg shadow-lg p-6">
            <h2 className="text-2xl font-semibold mb-4 text-gray-700">
              Upload Image
            </h2>
            <ImageUpload onImageUpload={handleImageUpload} />
          </div>
          
          <div className="bg-white rounded-lg shadow-lg p-6">
            <h2 className="text-2xl font-semibold mb-4 text-gray-700">
              Image Gallery
            </h2>
            {loading ? (
              <div className="flex justify-center items-center h-64">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
              </div>
            ) : (
              <ImageGallery 
                images={images} 
                onImageDelete={handleImageDelete}
              />
            )}
          </div>
        </div>
      </div>
    </main>
  )
} 