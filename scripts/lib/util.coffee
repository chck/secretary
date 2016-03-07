class Util
  #zero padding
  zp = (num) -> ("00" + num).slice(-2).toString()

  @withDate: (prefix) ->
    d = new Date()
    yyyy = "20" + zp(d.getYear())
    MMdd = zp(d.getMonth() + 1) + zp(d.getDate())
    Hm = zp(d.getHours()) + zp(d.getMinutes())
    "#{prefix}_#{yyyy}.#{MMdd}.#{Hm}"

module.exports = Util
