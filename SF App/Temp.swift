
import Foundation
import SwiftUI




struct contentView: View {
    
    @State private var location: CGPoint = CGPoint(x: 200, y: 105)
    @State var progressValue: Float = 0.0
    var body: some View {
        
               
        VStack  {

            ProgressBar(progress: self.$progressValue)
                .frame(width : 180.0 , height : 180.0)
                .padding(900.0).onAppear(){
                    self.progressValue = Float(SleepController().final()*SleepController().percentage*100)
                }.background(Color.myCustomColor)
                .position(location)
            
            Text("Congratulations!")
                .padding()
                .position(x: 210, y: 90)
                .foregroundColor(Color.white)
                .font(.system(size:30, weight:.light,design: .serif))
                .font(.title.bold())
            
            let c: String = String(format: "%.2f", SleepController().final()*100) + "%"
            
            Text(c)
                .padding()
                .position(x: 210, y: -160)
                .foregroundColor(Color.white)
                .font(.title.bold())
            
            let d: String = String(format: "%.2f",  SleepController().final()*200)
            
            Text("You Saved :")
                .padding()
                .position(x: 210, y: -120)
                .foregroundColor(Color.white)
                .font(.system(size:30, weight:.light,design: .serif))
                .font(.title.bold())
            
            Text(" $ " + d)
                .padding()
                .position(x: 210, y: -190)
                .foregroundColor(Color.white)
                .font(.system(size:30, weight:.light,design: .serif))
                .font(.title.bold())
                
            Text("Disclaimer: Amount Stated Above is out of 10%")
                .padding()
                .position(x: 210, y: 90)
                .foregroundColor(Color.white)
                .font(.system(size:12, weight:.light,design: .serif))
                .font(.title.bold())
        
        }
        
        
    }
    
}
struct ProgressBar: View{
    @Binding var progress: Float
    var color: Color = Color.white
    
    var body: some View {

        ZStack{
           
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.5)
                .foregroundColor(Color.gray)
                
            Circle().offset()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))  // change here for the percentages and use this to change when progress is added
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    //.opacity(0.2)
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
                        
            
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        contentView()
    }
    
    
}
class SwiftUIViewHostingController: UIHostingController<contentView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: contentView())
    }
}

extension Color {
    public static var myCustomColor: Color {
        return Color(UIColor(red: 240/255, green: 23/255, blue: 22/255, alpha: 1.0))
    }
}
